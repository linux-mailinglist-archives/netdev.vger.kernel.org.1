Return-Path: <netdev+bounces-27710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C3A77CEF1
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 17:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA6A281565
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 15:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0711114A90;
	Tue, 15 Aug 2023 15:18:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17DB134CB
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 15:18:37 +0000 (UTC)
Received: from out-19.mta1.migadu.com (out-19.mta1.migadu.com [IPv6:2001:41d0:203:375::13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB7E1991
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 08:18:21 -0700 (PDT)
Message-ID: <d5c30de7-df89-18dd-3ad8-a5d99c1e7108@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692112700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5jkRrsW9ZohDgZxdapSfROnd5WC/t+pIz3Z7RYOCEpk=;
	b=c5FEo+pNIRIQR7Ia0XE3msfztl33UetjSbeMLnJyhUSRhDUCP2kxoRpHGyDdwiMOcjW43J
	qoHzwqxkoMhZFA8/CC1eUtKOuhQ/885vlEtdkrFqcVDLMYBer7/m3NNBBM1aFld7cbsGE7
	w8ziAMKjx3NN87XuwGAI6Vrfj8zshdw=
Date: Tue, 15 Aug 2023 16:18:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 4/9] dpll: netlink: Add DPLL framework base
 functions
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Milena Olech <milena.olech@intel.com>,
 Michal Michalik <michal.michalik@intel.com>,
 linux-arm-kernel@lists.infradead.org, poros@redhat.com, mschmidt@redhat.com,
 netdev@vger.kernel.org, linux-clk@vger.kernel.org,
 Bart Van Assche <bvanassche@acm.org>, intel-wired-lan@lists.osuosl.org,
 Jiri Pirko <jiri@nvidia.com>
References: <20230811200340.577359-1-vadim.fedorenko@linux.dev>
 <20230811200340.577359-5-vadim.fedorenko@linux.dev>
 <20230814202441.349586b4@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230814202441.349586b4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 15/08/2023 04:24, Jakub Kicinski wrote:
> On Fri, 11 Aug 2023 21:03:35 +0100 Vadim Fedorenko wrote:
>> +	xa_for_each(&pin->dpll_refs, i, ref) {
>> +		const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
>> +		struct dpll_device *dpll = ref->dpll;
>> +
>> +		if (!ops->frequency_set)
>> +			return -EOPNOTSUPP;
>> +		ret = ops->frequency_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
>> +					 dpll, dpll_priv(dpll), freq, extack);
>> +		if (ret)
>> +			return ret;
>> +		__dpll_pin_change_ntf(pin);
>> +	}
> 
> only one freq is reported in get, AFAICT, so why send a notification
> after each ref is updated?

The pin can be technically connected to several DPLLs and app may watch
for the specific DPLL messages only. We would like to inform all users 
on any DPLL which has this pin connected to.

