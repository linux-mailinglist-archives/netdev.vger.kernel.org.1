Return-Path: <netdev+bounces-93833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7228BD565
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 21:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8311DB23025
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 19:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E73159204;
	Mon,  6 May 2024 19:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YIsuNfXV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5CB1591F6
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 19:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715023540; cv=none; b=lVjhiLl9FNcnlxm+2C6bu+QjII6dm2c6PmyGlny+N/LEUQBwBfwYW14LZXHeYeyNQcKOQtkEKYW60Hw0NTiTI5ut14OOSH03tX4Cw96yJ5R6gVoQObmg6tEV5fb9v0/ZqbxecjGflJsQbpCZwykgyHUyLASZtwoafYOT5aB4Xsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715023540; c=relaxed/simple;
	bh=1tpg9/GemBWEK7F/XJm+HAcU8KAJIEyMN6baH3oq51E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qCk/m/u8+C6FSbmeY5ExZtdGOj43YUd4kUT5Peu0GmkqIQsoA3jSuj4Yaow2SoyrTisq4tcdDJu/mPv4XH7MSbKB16vz15/A9MXFlFugL/Ybal1XDV/JSGMfZ+GzpbZa+BKIMN8dc1E3dan69CXN6ytGJmBs146ZR+of9z3ZKEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YIsuNfXV; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1eca195a7c8so18101165ad.2
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 12:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715023538; x=1715628338; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=StRehpmzXSBn0A7j37IsJYJGOn3KNpnBXUKZNAbi7BQ=;
        b=YIsuNfXVlDS0PIqsIcZcAa7DkE/Wf9xRTLSalKlj0AULcDcxJyroO01MwIP1BSzRa2
         s/QJPQhKew0gRsG3EoCqITPaT2tG9PC+BQksyH2GqG1THlReZXoXtRL3T2+FzPqrwwkb
         BUIAKektU21qn6mzh1fs5PfiCoVkoeib5drwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715023538; x=1715628338;
        h=in-reply-to:autocrypt:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=StRehpmzXSBn0A7j37IsJYJGOn3KNpnBXUKZNAbi7BQ=;
        b=KWPXL7wMh6c8e3HJQLeELzfL7rv/53M63gSsc6P7Pbtq9CyzFcuuxP99UrNkXotsxC
         YbcUlTX0NIbe9b4PxMuPjuBdhqwyFRxICgn/tjm9NXV19hD6nINZlgcFOoX7u/SYvMkc
         hMEHT0MU8liC7Mi/IHhlrkfqz8fBprbHstiQKeWiOVwVm+GNWWYc2CBAJlDoqaFZL5F9
         Dek88aycNN1Ve3KpN19a6rU0U/GA+FqoG+v6AIIZi12jegigkbVu7Gl5R53tZ8QDQgn6
         MoG5HufZb5n88J0/vmCLmO3oyzT2Ga4Af+qNGeRyogbDQYm1AJv1viLj0zdsa58GnlIG
         alDg==
X-Gm-Message-State: AOJu0YxsxLaxF6fIg37Qa6DX31UV5Y1deMEKqrVDKmD6SMb/1UbqK8u4
	zHPkIwUODL4zsqnVsNFB8ng4vV2uJiY22r5bkSzg8YhDMvncQia4+RTAdblbYQ==
X-Google-Smtp-Source: AGHT+IFqYqQgXxXIeouBe2vzRzoYvBj+XpiNRXYcRcrFMNab4SoFMGwm7asqgoxwxGCirHx6syhaTw==
X-Received: by 2002:a17:902:e949:b0:1eb:ed2:f74c with SMTP id b9-20020a170902e94900b001eb0ed2f74cmr13521742pll.67.1715023537900;
        Mon, 06 May 2024 12:25:37 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j11-20020a170902da8b00b001eb5c4054a4sm8566324plx.237.2024.05.06.12.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 12:25:37 -0700 (PDT)
Message-ID: <e7beb143-3c0d-4faf-8602-0cca63dd3b10@broadcom.com>
Date: Mon, 6 May 2024 12:25:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] net: phy: bcm54811: Add LRE registers definitions
To: =?UTF-8?Q?Kamil_Hor=C3=A1k_-_2N?= <kamilh@axis.com>,
 florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 andrew@lunn.ch, hkallweit1@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240506144015.2409715-1-kamilh@axis.com>
 <20240506144015.2409715-3-kamilh@axis.com>
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20240506144015.2409715-3-kamilh@axis.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000cb911e0617ce08a4"

--000000000000cb911e0617ce08a4
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/6/24 07:40, Kamil Horák - 2N wrote:
> Add the definitions of LRE registers for Broadcom BCM5481x PHY

Missing Signed-off-by tag.

> ---
>   include/linux/brcmphy.h | 91 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 90 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/brcmphy.h b/include/linux/brcmphy.h
> index 1394ba302367..9c0b78c1b6fb 100644
> --- a/include/linux/brcmphy.h
> +++ b/include/linux/brcmphy.h
> @@ -270,16 +270,105 @@
>   #define BCM5482_SSD_SGMII_SLAVE		0x15	/* SGMII Slave Register */
>   #define BCM5482_SSD_SGMII_SLAVE_EN	0x0002	/* Slave mode enable */
>   #define BCM5482_SSD_SGMII_SLAVE_AD	0x0001	/* Slave auto-detection */
> +#define BCM5482_SSD_SGMII_SLAVE_AD	0x0001	/* Slave auto-detection */
> +
> +/* BroadR-Reach LRE Registers. */
> +#define MII_BCM54XX_LRECR		0x00	/* LRE Control Register                    */
> +#define MII_BCM54XX_LRESR		0x01	/* LRE Status Register                     */
> +#define MII_BCM54XX_LREPHYSID1		0x02	/* LRE PHYS ID 1                           */
> +#define MII_BCM54XX_LREPHYSID2		0x03	/* LRE PHYS ID 2                           */
> +#define MII_BCM54XX_LREANAA		0x04	/* LDS Auto-Negotiation Advertised Ability */
> +#define MII_BCM54XX_LREANAC		0x05	/* LDS Auto-Negotiation Advertised Control */
> +#define MII_BCM54XX_LREANPT		0x06	/* LDS Ability Next Page Transmit          */
> +#define MII_BCM54XX_LRELPA		0x07	/* LDS Link Partner Ability                */
> +#define MII_BCM54XX_LRELPNPM		0x08	/* LDS Link Partner Next Page Message      */
> +#define MII_BCM54XX_LRELPNPC		0x09	/* LDS Link Partner Next Page Control      */
> +#define MII_BCM54XX_LRELDSE		0x0a	/* LDS Expansion Register                  */
> +#define MII_BCM54XX_LREES		0x0f	/* LRE Extended Status                     */
> +
> +/* LRE control register. */
> +#define LRECR_RESET			0x8000	/* Reset to default state      */
> +#define LRECR_LOOPBACK			0x4000	/* Internal Loopback           */
> +#define LRECR_LDSRES			0x2000	/* Restart LDS Process         */
> +#define LRECR_LDSEN			0x1000	/* LDS Enable                  */
> +#define LRECR_PDOWN			0x0800	/* Enable low power state      */
> +#define LRECR_ISOLATE			0x0400	/* Isolate data paths from MII */
> +#define LRECR_SPEED100			0x0200	/* Select 100 Mbps             */
> +#define LRECR_SPEED10			0x0000	/* Select 10 Mbps              */
> +#define LRECR_4PAIRS			0x0020	/* Select 4 Pairs              */
> +#define LRECR_2PAIRS			0x0010	/* Select 2 Pairs              */
> +#define LRECR_1PAIR			0x0000	/* Select 1 Pair               */
> +#define LRECR_MASTER			0x0008	/* Force Master when LDS disabled */
> +#define LRECR_SLAVE			0x0000	/* Force Slave when LDS disabled  */

So previous register had definitions ordered from MSB to LSB...

> +
> +/* LRE status register. */
> +#define LRESR_ERCAP			0x0001	/* Ext-reg capability          */

and here we have LSB to MSB, seems like you chose MSB to LSB, so we 
should stick to that.

> +#define LRESR_JCD			0x0002	/* Jabber detected             */
> +#define LRESR_LSTATUS			0x0004	/* Link status                 */
> +#define LRESR_LDSABILITY		0x0008	/* Can do LDS                  */

Comment should be LDS auto-negotiation capable, other comments are fine.

> +#define LRESR_8023			0x0010	/* Has IEEE 802.3 Support      */
> +#define LRESR_LDSCOMPLETE		0x0020	/* LDS Auto-negotiation complete */
> +#define LRESR_MFPS			0x0040	/* Can suppress Management Frames Preamble */
> +#define LRESR_RESV			0x0080	/* Unused...                   */
> +#define LRESR_ESTATEN			0x0100	/* Extended Status in R15      */
> +#define LRESR_10_1PAIR			0x0200	/* Can do 10Mbps 1 Pair        */
> +#define LRESR_10_2PAIR			0x0400	/* Can do 10Mbps 2 Pairs       */
> +#define LRESR_100_2PAIR			0x0800	/* Can do 100Mbps 2 Pairs      */
> +#define LRESR_100_4PAIR			0x1000	/* Can do 100Mbps 4 Pairs      */
> +#define LRESR_100_1PAIR			0x2000	/* Can do 100Mbps 1 Pair       */
> +
> +/* LDS Auto-Negotiation Advertised Ability. */
> +#define LREANAA_PAUSE_ASYM		0x8000	/* Can pause asymmetrically    */
> +#define LREANAA_PAUSE			0x4000	/* Can pause                   */
> +#define LREANAA_100_1PAIR		0x0020	/* Can do 100Mbps 1 Pair       */
> +#define LREANAA_100_4PAIR		0x0010	/* Can do 100Mbps 4 Pair       */
> +#define LREANAA_100_2PAIR		0x0008	/* Can do 100Mbps 2 Pair       */
> +#define LREANAA_10_2PAIR		0x0004	/* Can do 10Mbps 2 Pair        */
> +#define LREANAA_10_1PAIR		0x0002	/* Can do 10Mbps 1 Pair        */
> +
> +#define LRE_ADVERTISE_FULL		(LREANAA_100_1PAIR | LREANAA_100_4PAIR | \
> +					 LREANAA_100_2PAIR | LREANAA_10_2PAIR | \
> +					 LREANAA_10_1PAIR)
> +
> +#define LRE_ADVERTISE_ALL		LRE_ADVERTISE_FULL
> +
> +/* LDS Link Partner Ability. */
> +#define LRELPA_PAUSE_ASYM		0x8000	/* Supports asymmetric pause   */
> +#define LRELPA_PAUSE			0x4000	/* Supports pause capability   */
> +#define LRELPA_100_1PAIR		0x0020	/* 100Mbps 1 Pair capable      */
> +#define LRELPA_100_4PAIR		0x0010	/* 100Mbps 4 Pair capable      */
> +#define LRELPA_100_2PAIR		0x0008	/* 100Mbps 2 Pair capable      */
> +#define LRELPA_10_2PAIR			0x0004	/* 10Mbps 2 Pair capable       */
> +#define LRELPA_10_1PAIR			0x0002	/* 10Mbps 1 Pair capable       */
> +
> +/* LDS Expansion register. */
> +#define LDSE_DOWNGRADE			0x8000	/* Can do LDS Speed Downgrade  */
> +#define LDSE_MASTER			0x4000	/* Master / Slave              */
> +#define LDSE_PAIRS_MASK			0x3000	/* Pair Count Mask             */

Please define LDSE_PAIRS_SHIFT and make the LDSE_%dPAIRS left shift by 12.

> +#define LDSE_4PAIRS			0x2000	/* 4 Pairs Connection          */
> +#define LDSE_2PAIRS			0x1000	/* 2 Pairs Connection          */
> +#define LDSE_1PAIR			0x0000	/* 1 Pair  Connection          */
> +#define LDSE_CABLEN_MASK		0x0FFF	/* Cable Length Mask           */
>   
>   /* BCM54810 Registers */
>   #define BCM54810_EXP_BROADREACH_LRE_MISC_CTL	(MII_BCM54XX_EXP_SEL_ER + 0x90)
>   #define BCM54810_EXP_BROADREACH_LRE_MISC_CTL_EN	(1 << 0)
>   #define BCM54810_SHD_CLK_CTL			0x3
>   #define BCM54810_SHD_CLK_CTL_GTXCLK_EN		(1 << 9)
> +#define BCM54810_SHD_SCR3_TRDDAPD		0x0100

Unrelated change?

> +
> +/* BCM54811 Registers */
> +#define BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL	(MII_BCM54XX_EXP_SEL_ER + 0x9A)
> +/* Access Control Override Enable */
> +#define BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_EN		BIT(15)
> +/* Access Control Override Value */
> +#define BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_OVERRIDE_VAL	BIT(14)
> +/* Access Control Value */
> +#define BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_VAL		BIT(13)

This register is not documented in my datasheet, but register 0x0E is, I 
am fine with using that one though.

>   
>   /* BCM54612E Registers */
>   #define BCM54612E_EXP_SPARE0		(MII_BCM54XX_EXP_SEL_ETC + 0x34)
> -#define BCM54612E_LED4_CLK125OUT_EN	(1 << 1)
> +#define BCM54612E_LED4_CLK125OUT_EN	BIT(1)

Unrelated change, and one that is arguably inconsistent with the 
definitions you are adding, I would stick with the style you used, since 
there are precedents for that in brcmphy.h.
-- 
Florian


--000000000000cb911e0617ce08a4
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDBP8P9hKRVySg3Qv5DANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE4MTFaFw0yNTA5MTAxMjE4MTFaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEZsb3JpYW4gRmFpbmVsbGkxLDAqBgkqhkiG
9w0BCQEWHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEA+oi3jMmHltY4LMUy8Up5+1zjd1iSgUBXhwCJLj1GJQF+GwP8InemBbk5rjlC
UwbQDeIlOfb8xGqHoQFGSW8p9V1XUw+cthISLkycex0AJ09ufePshLZygRLREU0H4ecNPMejxCte
KdtB4COST4uhBkUCo9BSy1gkl8DJ8j/BQ1KNUx6oYe0CntRag+EnHv9TM9BeXBBLfmMRnWNhvOSk
nSmRX0J3d9/G2A3FIC6WY2XnLW7eAZCQPa1Tz3n2B5BGOxwqhwKLGLNu2SRCPHwOdD6e0drURF7/
Vax85/EqkVnFNlfxtZhS0ugx5gn2pta7bTdBm1IG4TX+A3B1G57rVwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUwwfJ6/F
KL0fRdVROal/Lp4lAF0wDQYJKoZIhvcNAQELBQADggEBAKBgfteDc1mChZjKBY4xAplC6uXGyBrZ
kNGap1mHJ+JngGzZCz+dDiHRQKGpXLxkHX0BvEDZLW6LGOJ83ImrW38YMOo3ZYnCYNHA9qDOakiw
2s1RH00JOkO5SkYdwCHj4DB9B7KEnLatJtD8MBorvt+QxTuSh4ze96Jz3kEIoHMvwGFkgObWblsc
3/YcLBmCgaWpZ3Ksev1vJPr5n8riG3/N4on8gO5qinmmr9Y7vGeuf5dmZrYMbnb+yCBalkUmZQwY
NxADYvcRBA0ySL6sZpj8BIIhWiXiuusuBmt2Mak2eEv0xDbovE6Z6hYyl/ZnRadbgK/ClgbY3w+O
AfUXEZ0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwT
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDT8kn5Yvu15/Z/k
7RZKwtZjjK+su3if5/lHTmvdvPtBMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTI0MDUwNjE5MjUzOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDI0/MezORtfBd9wrcHCRz5VIiIZmEtaN9C
m+j6kJhn+sYpUZQMZdFan+e1W5jmB2mbuNW+vdTnx8zz/+H7T219m2jdk/70//ud7facl54DqAnq
KfrxfKli6CMGBudHbumsrA0UOvByc82xlNytFH/u09UnJrDv9/YofZ9IXdKsgf8KUz+JqiSnMZtk
zpxF8gctWWlKLXNMFgWsqB1T6Mug3QlsfbJRr41JZo8jdanGQ8UwQegDvr4enSsH+9K4fTOJPB/W
hYVj0EpOPkltU4xTtAQJ2yUDMSVJ4DCYbLDomAKStMzurE+vv4SzNFMf4DvOm4ouwYSgITVivNql
I+1A
--000000000000cb911e0617ce08a4--

