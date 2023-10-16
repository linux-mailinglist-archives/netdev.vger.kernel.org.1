Return-Path: <netdev+bounces-41437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC907CAF13
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 18:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C21281045
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 16:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E06330D16;
	Mon, 16 Oct 2023 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="lbtQRtg2";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="lbtQRtg2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDAE30CF5;
	Mon, 16 Oct 2023 16:24:14 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03hn2245.outbound.protection.outlook.com [52.100.14.245])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E7383E4;
	Mon, 16 Oct 2023 09:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWcdof4bs4v1dFcXg/KVKjaL424b5bLcDR/W6zIcJI0=;
 b=lbtQRtg2UyrEvKkxDbbUxr/kRJGj3IKXO0S94NE20Eenq0RtQzdabNenrh01ZJAa72rxphSyNHjDpUiDBeWdfg6bNaEJLTmDe8eKCNNF/EWGkuMvku0St8SNZpwN/WdgjboeLtESyZUnX1G5jZ/c8PB3e7EGkCdd/mcmpbjvYKmWlkMkdB2EWrssNxzwcuQG9/0tqNl00SEnCyFJLjJWgpXwhNq/nQWa/T+YL4mzG3RXAR40z9/0ODcJcIO6f/gZ49Ideib9ovEXIT+JtvdBwF4UuwDTC94P8eCnXpNFiqta3zbcbzwMeSZm9q1Av6Nn2/Fq/jBSZCZ7siAyFDB3/A==
Received: from AS9PR06CA0142.eurprd06.prod.outlook.com (2603:10a6:20b:467::35)
 by AM7PR03MB6596.eurprd03.prod.outlook.com (2603:10a6:20b:1b0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 16:24:09 +0000
Received: from VI1EUR05FT024.eop-eur05.prod.protection.outlook.com
 (2603:10a6:20b:467:cafe::5a) by AS9PR06CA0142.outlook.office365.com
 (2603:10a6:20b:467::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 16:24:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.81)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.81 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.81; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.81) by
 VI1EUR05FT024.mail.protection.outlook.com (10.233.242.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.20 via Frontend Transport; Mon, 16 Oct 2023 16:24:08 +0000
Received: from outmta (unknown [192.168.82.132])
	by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 41FD8200813AA;
	Mon, 16 Oct 2023 16:24:08 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (unknown [104.47.17.105])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id B54882008006E;
	Mon, 16 Oct 2023 16:23:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HyQUWg7bALYuLJw8csY7HdEqvKTCsTtC39EK2xVqkj0Z9PEnxvmytNjy8CCsNU5X2b5YKcLVnh6aH4mLN22eQI3bgia6qXTDhzauIGzveS93i5stB9L6/gbbWHubAhD0CY1Q3C6LCYIbcdPQO7icCPxA+BOdKLm4Ah/cf3kSfiJgjjT0xDUd5XJAZ0iSaz7S8quE0HqtBxMggpazIz/Xn6EtuPq3VHISV0uWdWKsMqy5ptp9ktEvw4E6vaa+9CW1kOcyk2bm3ELOfDWg6dtj2iXLNVkGc4kl0DTCjbhbSdp5kSvd8dcflFQI3p40H02892X12FYpA9K/eqBLF74JJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWcdof4bs4v1dFcXg/KVKjaL424b5bLcDR/W6zIcJI0=;
 b=G9DzEUYyxjXxi+zkEYobcMSdW4qp6WjmbtpEh77Qfk5YDwIvjiEn+aRzKV5r9VEwana4PcyZSfcDvQnMnszjIoNoxMRSlO5JsG2y0U9EvMjKJNHJXPqolmJjJ7zYOjQEN5rHCZYXTlO2I8fRY/ND7ZbK8W1LaHnu21xOu1k18o+rGfGKJX/bpkPAkXwl7T3SO3OaPeWp02NFyooqpoWd9hp+JxKBxG9J+V9vn9pJ5yEkWs8SNfnsMNYyAdjLbxsd6fvZwzOptV53AvXgY2OWRsfTbFszVHTfQOEXLyhhbVlDiMcN9HPFgSrcgT6zcxpaBa7BWwmKYvEdE7rQoDNOXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWcdof4bs4v1dFcXg/KVKjaL424b5bLcDR/W6zIcJI0=;
 b=lbtQRtg2UyrEvKkxDbbUxr/kRJGj3IKXO0S94NE20Eenq0RtQzdabNenrh01ZJAa72rxphSyNHjDpUiDBeWdfg6bNaEJLTmDe8eKCNNF/EWGkuMvku0St8SNZpwN/WdgjboeLtESyZUnX1G5jZ/c8PB3e7EGkCdd/mcmpbjvYKmWlkMkdB2EWrssNxzwcuQG9/0tqNl00SEnCyFJLjJWgpXwhNq/nQWa/T+YL4mzG3RXAR40z9/0ODcJcIO6f/gZ49Ideib9ovEXIT+JtvdBwF4UuwDTC94P8eCnXpNFiqta3zbcbzwMeSZm9q1Av6Nn2/Fq/jBSZCZ7siAyFDB3/A==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by PAXPR03MB8082.eurprd03.prod.outlook.com (2603:10a6:102:231::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 16:23:56 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::4824:99ed:da95:6bd0]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::4824:99ed:da95:6bd0%6]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 16:23:56 +0000
Message-ID: <0c8fef5d-fb88-4253-8c39-4a1254c8764f@seco.com>
Date: Mon, 16 Oct 2023 12:23:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] net: fman: convert to .mac_get_caps()
Content-Language: en-US
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 Madalin Bucur <madalin.bucur@nxp.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <ZS1Z5DDfHyjMryYu@shell.armlinux.org.uk>
 <E1qsPkA-009wid-Kv@rmk-PC.armlinux.org.uk>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <E1qsPkA-009wid-Kv@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:208:160::19) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR03MB8847:EE_|PAXPR03MB8082:EE_|VI1EUR05FT024:EE_|AM7PR03MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b0530fb-328c-4593-c901-08dbce6452f6
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 09hdKdZr8nv/jZOxL/KawgA/XK4Up4JVhvUaDJkMerdvTVxx9ZuQdroXiDIlFe+YXbKWmM2VUZ2VJz6sbFWcMyA5KnqVAxd4h98hzTQQcg5EIRfODfoCmTSoGmAu+YzYrpyaQztF0WMpLkKJ2kRFEjZ3LPXBLYc3/iRizNdHYBzUR8yGhavRc+pyr2ZheB4ZknU1BuM1blVIT1qV0HGL1lVsOK565y8vxbIiXJxY7vkIPUoEFTN+DBuJE1JPy6LVnJSPPtZ3ZpClyPc/1H3EMCGIl5zYVXBTX26NoO1nj9KObcBuPmf6dAXB/r2mKLl9qMN2cwiraQShvErr0cp/+9rMTWWTCNdUT4YBSYYtxbhndQrWae3Xa027DPAsnJxKxZ+4IJenuvBuzK8Cm4pR1nAekjwLSWAEizIQVGbbhXnNbuH45bQY6PSC5sQH23ke/p01Ww9THZ9dnVPA+F0UmcgYsAoGK2MG2PcE+wAbpEVwwh08VQN0aA2jflnZCnkQFHhyEFM2XOv/6NA2qqb9holybu6cTy6UKx2QalC6kz6E6cDm4ICDwV3uZsvtovW5cowbSRWZ/1O06/yrC3ndnQfjxtv5UtmXvTabwb/L7MPoOep0dsXtDmJ36+How+AUDn4aEtOHUCnYGRUlhEG1lnNk4DhGYPaMbHRTofFDjrKzFFJY/smc/iBSxL9ZLcANdYZF5zxnq79yhxakS6iBlw==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(376002)(39850400004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(6506007)(52116002)(53546011)(5660300002)(44832011)(6666004)(2906002)(26005)(36756003)(83380400001)(2616005)(38100700002)(86362001)(6512007)(31696002)(7416002)(478600001)(6486002)(41300700001)(316002)(66556008)(110136005)(54906003)(66946007)(66476007)(38350700005)(31686004)(4326008)(8936002)(8676002)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB8082
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 VI1EUR05FT024.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	608b5dae-ec69-44b4-7419-08dbce644b93
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sZBhnRMWVDQnwGOr7Q6yp4Bdq/TSdsaezt06vnUczdOMuklNpy6l75jVoW350tVHAnmehVxldNO4BAbTZHlzmVYCaweWJrezzY2kOo8wFXs65UGKvHJF0QYoLVcomV9896AUrKc9R9hIHUyuZlUTjM6t4z9OdqGgYhj8RGYU5Ig+h0bmatq3uTA5vxyWX+YqtLXV3z46Drq448oAO1X7knvtmlJuSngeNAyavRx/ba5R7HSHLH3AHJExzMUlNwQsZgAHwK5cNLQCP8KN3q21WJg5LIC5h1aniYvfTWSeq3MDLnXlO5KAUgm4rYsJB9PbewlxxOQ1jVrYPH4LlsUQFDNb9bWAsJgzqdaLu4DU7djUvLhPtKhUeJqfUANoLaj6kXcouuSyK7x3h80ZNHxUMwM1uZptIhBbHuWTt2epV0kSNquBDCtLUEDsu/uGAbRPEWSAYNiug2yq0JfyURIjrusXhV7Bz5cWTHzVCHUTLriMDEGNGmwdLFn1pPKnNg3dXHJxgdO2Q9JfAYeYcfWxHqbhFfYIh1j/aUwOAirJg1+rWRgBvvE+Wy3Q62V3fzprtM7QJA4/J28L1qb275WAXJW5ybgSzUK0u5erteO+7FiKp/gxF9UIL6ZYaDkxXBYB7tgkYjv6hPOnG8dEjDt3SmtAUYZCoCv3pyyyWyhQlWVpFtN+yLA+4fbIiu7pubrOOypeJtFl/qp1J70qWb3xNKpF176qqxkZhxIPm0FQdWxO1zNb0RnAFVe5gRNQZQoNnvYPR7686aB5bpMDiSfB2YRKB6AlhQVjkUNRGvfix/otFn91LIScNmali0hAzEx65Gy+ujgwbgqNreoNbGXKXQ==
X-Forefront-Antispam-Report:
	CIP:20.160.56.81;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:inpost-eu.tmcas.trendmicro.com;PTR:inpost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(396003)(39850400004)(376002)(346002)(136003)(230922051799003)(1800799009)(186009)(82310400011)(64100799003)(451199024)(5400799018)(46966006)(36840700001)(336012)(36860700001)(2616005)(83380400001)(34020700004)(6512007)(47076005)(7416002)(70206006)(110136005)(8676002)(4326008)(54906003)(70586007)(8936002)(316002)(6666004)(41300700001)(6506007)(53546011)(7636003)(7596003)(44832011)(5660300002)(478600001)(2906002)(6486002)(82740400003)(356005)(40480700001)(31696002)(86362001)(36756003)(31686004)(26005)(142923001)(43740500002)(12100799048);DIR:OUT;SFP:1501;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 16:24:08.6232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0530fb-328c-4593-c901-08dbce6452f6
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.81];Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VI1EUR05FT024.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6596
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/16/23 11:42, Russell King (Oracle) wrote:
> Convert fman to use the .mac_get_caps() method rather than the
> .validate() method.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/freescale/fman/fman_memac.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/net/ethernet/freescale/fman/fman_memac.c
> index 3b75cc543be9..9ba15d3183d7 100644
> --- a/drivers/net/ethernet/freescale/fman/fman_memac.c
> +++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
> @@ -618,18 +618,17 @@ static int memac_accept_rx_pause_frames(struct fman_mac *memac, bool en)
>  	return 0;
>  }
>  
> -static void memac_validate(struct phylink_config *config,
> -			   unsigned long *supported,
> -			   struct phylink_link_state *state)
> +static unsigned long memac_get_caps(struct phylink_config *config,
> +				    phy_interface_t interface)
>  {
>  	struct fman_mac *memac = fman_config_to_mac(config)->fman_mac;
>  	unsigned long caps = config->mac_capabilities;
>  
> -	if (phy_interface_mode_is_rgmii(state->interface) &&
> +	if (phy_interface_mode_is_rgmii(interface) &&
>  	    memac->rgmii_no_half_duplex)
>  		caps &= ~(MAC_10HD | MAC_100HD);
>  
> -	phylink_validate_mask_caps(supported, state, caps);
> +	return caps;
>  }
>  
>  /**
> @@ -776,7 +775,7 @@ static void memac_link_down(struct phylink_config *config, unsigned int mode,
>  }
>  
>  static const struct phylink_mac_ops memac_mac_ops = {
> -	.validate = memac_validate,
> +	.mac_get_caps = memac_get_caps,
>  	.mac_select_pcs = memac_select_pcs,
>  	.mac_prepare = memac_prepare,
>  	.mac_config = memac_mac_config,

Reviewed-by: Sean Anderson

