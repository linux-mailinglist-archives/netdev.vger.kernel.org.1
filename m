Return-Path: <netdev+bounces-282899-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GmWB6F182mt4AEAu9opvQ
	(envelope-from <netdev+bounces-282899-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:30:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFC94A4CBB
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3643303012F
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBF02D9ECA;
	Thu, 30 Apr 2026 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZIwUFNgt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FE623A566
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777562468; cv=none; b=i9cHMi2rde870SsNEuNVdS1u6mKKWO4qC27BiDDFywWfrwMoVQpnxmd0ik4N+tY88y8UYldqbhDsYB+B7zlckWczrZV0OJ4RR2uAgkmB7IQtgGkDC/On1p1qJDEYocdzpkaF9qnVIz6Y3/8DRskbZ53x42XHdtjNenTdYhnSkkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777562468; c=relaxed/simple;
	bh=jfvurasXyO172rf8RueovQ21HocKi4qC6cmZUk6WC5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBhcD1xBdErJayU+VOA4hCTOo7oXkW+HVuh8/4v8isqK8unNTSGec14g5eeIgWoQs/RKSMTdDpvyLnA+jVsD1hWDmUzd7hO8arpm0bJORnTQXK8zxVYbhgWjUm1N9Jm71od/geKnFvbAoiV1qbr+PJbDbiBvb5FvAhvxv4BGEQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZIwUFNgt; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-8f231f3b130so73897585a.3
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777562466; x=1778167266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6W7N3TF0u0m9VhuQZcYonFJHVZpaP1eZOWODDM2/uM=;
        b=KKj9gFfbtUz8GOfwBPnsZ8XkPPHj5ljm0fKsVPO6s+jYKmfx+4ofcLCoFJK3vWy8a4
         zkpIJB1rgQb79XIHYStjWxc+0+Nafb7OFnSgriQngIxRQesd1gApIWa3EsXE698PDcGX
         789wXpO0q2sNJSKyvwkm9v5zknv4om91Lqjzeal/nVKni4uoSRV6RmHVKK6HOnrcvyvc
         KQRq+EQnE4S4YfhmkNOOf+sST3Fn4JYuR5fFW/liJp8JBdl2iRhv9NmS+KQAMS3mRqAN
         ktRGqU4efL2kr4W7z9a1xciQlhzEPBzcMi3UfHYEHaAgEGIknEipEhTp0NpC9hXnFtME
         kCZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/vbk4DplM/9yIYoVyYhueNDB6TjiFSx9gE+2uuYQ21g8gWy0A8XKXcGx8CKb+/jwVSb2Sqbwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDl+WClAuJwOjfBjdAUE9RLzo+gbt6kgodYr3OfqoYHwttBiaO
	XeCZ5T9qsFYWx7ftQowRA4OPx6525CkIvoSwcCU8m+v3bRQzGj+WA3eqVjlAwlN70wiH/yNT7bD
	Sgnt7nlRn7iS6s2nKa9wRyblZ//3eL9YZsKtw9LerGcZUO5ujmjzMNIXLy05xLJng4FR6T8n+1x
	CvVSQLCBs2tpL5rDbIP4b3NFulkwUk2tE0Og3Ipnu61g8C1vnCDk8XADQDyN0AGzSqNzouE/3Vo
	LICA2TaQ9UFJhXrfA==
X-Gm-Gg: AeBDievKEgZNm5C0Qq4Ncbxe99t3HwNPcf0bgmFlOt8hz4Clm2nkIYA51DaP+gWoAhm
	tE/FB92GmQ5oXYwnojN4SLQtHx4Lpkgbsdv9IZoyNpLnIGTIXJB8RpbmQB4M0KKUturoTm/Tq3V
	lrGGh1MfVJyHbqFRvnd8sB9DUUiltc/7MZn7P+4qQ5fGanJZKFYX3yDx/GJ14hyxV4FN+cjSojr
	nscB4hxYVuucpc6T044O09v1Pst9XoPH6rO7E0B4GE+pbogk+dEx+JZ+SkMnbviV++gTopNDmJG
	AAw9DWQUgTosKfnZn1NpXvLVlk/B/hNNUNguN/Kg32vfMSMD7jUMYqfpGZPufW1pVPogdBDECOW
	G8Kc4/d2OVxu8BBjh0dB3DQ4QXOdInvuxtVeCjct/08tmDE9TNiz1IoINackmLL6o55OkfkG96w
	+Un9mRN0Kquo0W5hNcn8b88wLGcQYh8+p4GRrpwC1KF2vxubiru8NOCpkykIry2eIeVAFBEeY=
X-Received: by 2002:ac8:58d2:0:b0:50e:6054:bc with SMTP id d75a77b69052e-5102ab43dc2mr48727221cf.16.1777562465341;
        Thu, 30 Apr 2026 08:21:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-5103b597c61sm8101cf.21.2026.04.30.08.21.04
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2026 08:21:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-12c20d5d7f4so4081064c88.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777562464; x=1778167264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j6W7N3TF0u0m9VhuQZcYonFJHVZpaP1eZOWODDM2/uM=;
        b=ZIwUFNgt2V5XwCvofb+4td7FgcV00prd/59z7qF9PnpMXYvqXCF1cxUZ4RT0xitYVP
         VK7XaKqOpKcXPT8DMw7U1SRnThSvz0hZDPUcwg3mzezTLwChabwWZblydM31j6z8Elqp
         FlrUwQt2ib9JtjYZ10qTrOTHDW5jUQTiUhflA=
X-Forwarded-Encrypted: i=1; AFNElJ8NcKjlndzoFiFIoIJygy0ECmkUo7MFkUe2lldnyexLT1dSzWh3EaY21A8j00QkFwikmazlJmc=@vger.kernel.org
X-Received: by 2002:a05:7300:fd03:b0:2d9:7bc4:9578 with SMTP id 5a478bee46e88-2ed3e386a41mr1602819eec.28.1777562094275;
        Thu, 30 Apr 2026 08:14:54 -0700 (PDT)
X-Received: by 2002:a05:7300:fd03:b0:2d9:7bc4:9578 with SMTP id 5a478bee46e88-2ed3e386a41mr1602745eec.28.1777562093564;
        Thu, 30 Apr 2026 08:14:53 -0700 (PDT)
Received: from [192.168.178.26] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38e71ccesm286774eec.10.2026.04.30.08.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 08:14:52 -0700 (PDT)
Message-ID: <f817f781-43d5-40d0-9352-20769d9a6601@broadcom.com>
Date: Thu, 30 Apr 2026 17:14:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: Consistently define pci_device_ids using
 named initializers
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>,
 Michael Grzeschik <m.grzeschik@pengutronix.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
 <mailhol@kernel.org>, Krzysztof Halasa <khc@pm.waw.pl>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Steffen Klassert <klassert@kernel.org>, David Dillow <dave@thedillows.org>,
 Ion Badulescu <ionut@badula.org>, Mark Einon <mark.einon@gmail.com>,
 Rasesh Mody <rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
 Ido Schimmel <idosch@nvidia.com>, Sudarsana Kalluru <skalluru@marvell.com>,
 Manish Chopra <manishc@marvell.com>, Potnuri Bharat Teja
 <bharat@chelsio.com>, Denis Kirjanov <kirjanov@gmail.com>,
 Jijie Shao <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>,
 Cai Huoqing <cai.huoqing@linux.dev>, Fan Gong <gongfan1@huawei.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 Petr Machata <petrm@nvidia.com>, Yibo Dong <dong100@mucse.com>,
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 nic_swsd@realtek.com, Jiri Pirko <jiri@resnulli.us>,
 Francois Romieu <romieu@fr.zoreil.com>, Daniele Venzano
 <venza@brownhat.org>, Samuel Chessman <chessman@tux.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou
 <mengyuanlou@net-swift.com>, Kevin Curtis <kevin.curtis@farsite.co.uk>,
 Stanislav Yakovlev <stas.yakovlev@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, Kees Cook <kees@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Thomas Fourier
 <fourier.thomas@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Zilin Guan <zilin@seu.edu.cn>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Jacob Keller <jacob.e.keller@intel.com>, Philipp Stanner
 <phasta@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Yeounsu Moon <yyyynoom@gmail.com>, Denis Benato <benato.denis96@gmail.com>,
 Peiyang Wang <wangpeiyang1@huawei.com>, Yonglong Liu
 <liuyonglong@huawei.com>, Andy Shevchenko <andriy.shevchenko@intel.com>,
 Yicong Hui <yiconghui@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
 MD Danish Anwar <danishanwar@ti.com>, Nathan Chancellor <nathan@kernel.org>,
 Sai Krishna <saikrishnag@marvell.com>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>, Joe Damato <joe@dama.to>,
 Double Lo <double.lo@cypress.com>, Chi-hsien Lin
 <chi-hsien.lin@cypress.com>, Colin Ian King <colin.i.king@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org, linux-parisc@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 oss-drivers@corigine.com, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com
References: <20260428171845.2288395-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <20260428171845.2288395-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 2CFC94A4CBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,thedillows.org,badula.org,gmail.com,marvell.com,nvidia.com,chelsio.com,huawei.com,linux.dev,intel.com,mucse.com,realtek.com,resnulli.us,fr.zoreil.com,brownhat.org,tux.org,trustnetic.com,net-swift.com,farsite.co.uk,bootlin.com,seu.edu.cn,suse.com,google.com,infradead.org,ti.com,dama.to,cypress.com,vger.kernel.org,lists.osuosl.org,corigine.com,lists.linux.dev,broadcom.com];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-282899-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[84];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]

On 28/04/2026 19:18, Uwe Kleine-König (The Capable Hub) wrote:
> ... and PCI device helpers.
> 
> The various struct pci_device_id arrays were initialized mostly by one
> the PCI_DEVICE macros and then list expressions. The latter isn't easily
> readable if you're not into PCI. Using named initializers is more
> explicit and thus easier to parse.
> 
> Also use PCI_DEVICE* helper macros to assign .vendor, .device,
> .subvendor and .subdevice where appropriate and skip explicit
> assignments of 0 (which the compiler takes care of).
> 
> The secret plan is to make struct pci_device_id::driver_data an
> anonymous union (similar to
> https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre.com/)
> and that requires named initializers. But it's also a nice cleanup on
> its own.
> 
> This change doesn't introduce changes to the compiled pci_device_id
> arrays. Tested on x86 and arm64.

for brcmfmac change...

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> ---
[...]

>   .../broadcom/brcm80211/brcmfmac/pcie.c        |  17 +-
>   drivers/net/wireless/intel/ipw2x00/ipw2200.c  |  52 +-
>   69 files changed, 1308 insertions(+), 1101 deletions(-)

