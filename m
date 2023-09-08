Return-Path: <netdev+bounces-32565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B91798674
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 13:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF6A1C20C67
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 11:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30604C94;
	Fri,  8 Sep 2023 11:29:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65774C7B
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 11:29:45 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8E2173B
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 04:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694172584; x=1725708584;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7OICOhKIDdF00mWteEBoT9ZnXSIEgmEN53eXWcTxwEk=;
  b=wSrLurYlCU7ixZvzwuOx8Ut8dWTXsUfGy43o7FeeysDOZ3/BzPKckNAF
   t0qhLeaR1J6mjWlxGYJJE0oXc/LAHSgzClccTz01h99VnwGJTs1EenbSN
   ZzsEtOCdREfoudSMK0JvIctWgB5EHZ5keJEtSPi1gJuWmewnL7xeTRLXs
   B5daWRoG9Fa7p3NEacINJcmQK0CgKoutaQDj4LdltUylMU0SFXl6nPkwn
   cxLsvw5T8O4p8y5nH+9UMkJtJx7DTVdeBpo0lCX2oYXecGCoBIETek3KO
   rfpftkWC8rJQ341dV0GHMEPw5lhkVgJnQaLk65YB3JMPhjuB0OT8xlScG
   g==;
X-CSE-ConnectionGUID: S4c1HwcQSUC4Aa+mSml7GA==
X-CSE-MsgGUID: jsxsVGWDQZGgzonVaX5FjA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="3513579"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2023 04:29:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 8 Sep 2023 04:29:35 -0700
Received: from DEN-LT-70577 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 8 Sep 2023 04:29:33 -0700
Date: Fri, 8 Sep 2023 11:29:33 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
CC: <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net 2/5] net: microchip: sparx5: Fix memory leak for
 vcap_api_rule_add_actionvalue_test()
Message-ID: <20230908112933.kvw5txzrw6l4rb2n@DEN-LT-70577>
References: <20230908040011.2620468-1-ruanjinjie@huawei.com>
 <20230908040011.2620468-3-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230908040011.2620468-3-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Inject fault while probing kunit-example-test.ko, the field which
> is allocated by kzalloc in vcap_rule_add_action() of
> vcap_rule_add_action_bit/u32() is not freed, and it cause
> the memory leaks below.
> 
> Fixes: c956b9b318d9 ("net: microchip: sparx5: Adding KUNIT tests of key/action values in VCAP API")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  .../net/ethernet/microchip/vcap/vcap_api_kunit.c  | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c b/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
> index 2fb0b8cf2b0c..aa79bcf3efc2 100644
> --- a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
> +++ b/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
> @@ -1095,6 +1095,16 @@ static void vcap_api_rule_add_keyvalue_test(struct kunit *test)
>         vcap_free_ckf(rule);
>  }
> 
> +static void vcap_free_caf(struct vcap_rule *rule)
> +{
> +       struct vcap_client_actionfield *caf, *next_caf;
> +
> +       list_for_each_entry_safe(caf, next_caf, &rule->actionfields, ctrl.list) {
> +               list_del(&caf->ctrl.list);
> +               kfree(caf);
> +       }
> +}
> +

Hi Jinjie,

It seems like you need to respin anyway, so could you please fix this
patch to adhere to the 80 character limit. Checkpatch generates a
warning.

/Daniel


