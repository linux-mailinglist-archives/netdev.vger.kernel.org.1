Return-Path: <netdev+bounces-16216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF0774BDB0
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 16:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0331C20933
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 14:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EC5746B;
	Sat,  8 Jul 2023 14:01:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13696FB6
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 14:01:08 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C357610EA
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 07:01:06 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qI8Uj-00032Y-5B; Sat, 08 Jul 2023 16:01:05 +0200
Message-ID: <ac2efb70-aa19-41d3-ac57-8aaaf39c620b@leemhuis.info>
Date: Sat, 8 Jul 2023 16:01:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Regression: supported_interfaces filling enforcement
Content-Language: en-US, de-DE
To: Sergei Antonov <saproj@gmail.com>, netdev@vger.kernel.org,
 Vladimir Oltean <olteanv@gmail.com>, rmk+kernel@armlinux.org.uk
References: <CABikg9wM0f5cjYY0EV_i3cMT2JcUT1bSe_kkiYk0wFwMrTo8=w@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CABikg9wM0f5cjYY0EV_i3cMT2JcUT1bSe_kkiYk0wFwMrTo8=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688824866;9b4fe350;
X-HE-SMSGID: 1qI8Uj-00032Y-5B
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 04.07.23 16:28, Sergei Antonov wrote:
> Hello!
> This commit seems to break the mv88e6060 dsa driver:
> de5c9bf40c4582729f64f66d9cf4920d50beb897    "net: phylink: require
> supported_interfaces to be filled"
> 
> The driver does not fill 'supported_interfaces'. What is the proper
> way to fix it? I managed to fix it by the following quick code.
> Comments? Recommendations?
> 
> +static void mv88e6060_get_caps(struct dsa_switch *ds, int port,
> +                              struct phylink_config *config)
> +{
> +       __set_bit(PHY_INTERFACE_MODE_INTERNAL, config->supported_interfaces);
> +       __set_bit(PHY_INTERFACE_MODE_GMII, config->supported_interfaces);
> +}
> +
>  static const struct dsa_switch_ops mv88e6060_switch_ops = {
>         .get_tag_protocol = mv88e6060_get_tag_protocol,
>         .setup          = mv88e6060_setup,
>         .phy_read       = mv88e6060_phy_read,
>         .phy_write      = mv88e6060_phy_write,
> +       .phylink_get_caps = mv88e6060_get_caps
>  };

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced de5c9bf40c4582729f6
#regzbot title net: phylink: mv88e6060 dsa driver broken
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

