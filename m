Return-Path: <netdev+bounces-165959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FD4A33CC2
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 11:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08962168D99
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 10:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FDA20E30A;
	Thu, 13 Feb 2025 10:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDt3hgyC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3992063D2
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 10:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739442750; cv=none; b=UCSIdLymt+sPJnvTQYldQULto2zceXqPXq+tPC3cxXT1xmVd9VWNFSNcdcM1aeI8hcHKqEeBtvV46OSWdLO2zMsOduj3XUGt+cjzajdEltiR/PbI6jzDCXNQi7Cf6g4ye7chkLWQWEv7Rimv3XFBwrsunicLQ2pxB9NoWMnokrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739442750; c=relaxed/simple;
	bh=RSb6AWuuOTKDXx/iwJOiFqPAdBRjDemlLkiLcOpxrPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cA2AdWSwX8prQEyQZ3BsefQdjqzJtR5N74Mp/W4R+JeB/TZbGzlEE78Auad323+aGL8ARWajJjA0juv6C/svR3a5twGLD6MhBg70E5dAxjXEAexJL5EQTvOJpTv/jfYFQjDhQc/IquiSWi1FzNdNPi+dVyLZoLpHdIMiwdUlqQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iDt3hgyC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739442747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ft4Xrl2F2mgPSEHxN3B5fwyLk6cWe4p7NtJxQ7scBGU=;
	b=iDt3hgyCoxKwqHKUUsrDEn1vCALtGHkO87IkaHkk4sCosKqOKJTA+/9/v/MlEYhfk4WA7O
	YEAIapYfpcYBMSHuM8nS3/v0EfYHbW1jk4M84ukpmH1G7sCaXfW3whuDHDZkryRNs3u3cV
	+DzZZl3Rric16LYVsIKv3ckaqQ+Xtzg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-Jve5j5qYO4uRhgSgf-YlUQ-1; Thu, 13 Feb 2025 05:32:25 -0500
X-MC-Unique: Jve5j5qYO4uRhgSgf-YlUQ-1
X-Mimecast-MFC-AGG-ID: Jve5j5qYO4uRhgSgf-YlUQ
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-545054b6a97so327081e87.1
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 02:32:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739442744; x=1740047544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ft4Xrl2F2mgPSEHxN3B5fwyLk6cWe4p7NtJxQ7scBGU=;
        b=Pkf3EQtgntbZdj2JrPkiej2sCqlDu+82WSoC10IYUDkXNxLbsB0YZm7zu2209lF0a1
         dHN498GYXaXVb7ThW190pMCQpQm0RtKu2a3NqKsaioaY0yil7MIyZ7sBAXiI4+cRe2RB
         +AffnSrR7vFgUg9oCiri/6G/bT7VNUjcXzJoeHWMit3G+ihrlgJPg3rozwsbb8R3/3MM
         PSNh42Q9JEgKIHGWPZJuWPm+b0VIxPy4kyuRl2rL3XKBNZr5ttEcdEZkM93ywlBBeAsA
         KY5Dovau5tjSP56nPp6jinAP1erOu2sISNUpjMlb8UUEGrxQnam2e1YdvO/bAX87Kyyv
         X44Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxKuJg/TMB/TRn/4DQ5xPYJgF35XzTDL9spOzi6CbCAYtpUWrPb0BFi9qM8tzkrH0ha+/d7tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPRqB0nksEbE38N8QMlHDzuOA1ljQmGP8CG/UApzqWyPDtyria
	SUmyQGO345UeiSzdMxlFkvV17n5rFcANlHgkfS1AoR8zg5JeBbbZUmActkB68N1A+BmVlnf0nZN
	gFkYz7fZMODv5OnA0nH1eFWHT9xrUR5rJs0rmMrja4P0SZF8GSFES+g==
X-Gm-Gg: ASbGnctGqub+S75K7X19TbIF+YRNxA7erezP/QwTCRwwhUz7YNNsphHdGFw4iXIHzdk
	YJ0gAGdsTuTwSHTSpeYIzb1LtWTYWIeCghKx7xIh6d5j4F/zzbjGcDcQ9g+TeAhe6JaFfpzt4pd
	Jav7BWDiOxstGc9VSSCMTp3S5S9MQxzSNH6b883p/PIJ71h7Mn744ndzjYE/F4Kze60M6BwpkNT
	5LI9isvgiqpbMxwcTqR8i2zc5kEkjGrp9umVOoY3K5KfpoDTCyh+jDkR+AO6GE8wiwHoC3zodG6
	TS6BuiFbpCUt/3wykLUkp9bjTZflYln81Tw=
X-Received: by 2002:a05:6512:1288:b0:542:8cf5:a3a3 with SMTP id 2adb3069b0e04-545180ea9bdmr2313805e87.5.1739442743788;
        Thu, 13 Feb 2025 02:32:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOjVjfgWpSxlDgp1d5SSfQqcJAl+Kj/IMfKejulsNDq4Ht7M1ACB2G+v8WrXUKd+ndKzht2A==
X-Received: by 2002:a05:6512:1288:b0:542:8cf5:a3a3 with SMTP id 2adb3069b0e04-545180ea9bdmr2313793e87.5.1739442743361;
        Thu, 13 Feb 2025 02:32:23 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f083443sm131485e87.33.2025.02.13.02.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 02:32:22 -0800 (PST)
Message-ID: <875da042-ef68-4036-beab-9beff1e21ab7@redhat.com>
Date: Thu, 13 Feb 2025 11:32:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] octeontx2-af: Fix uninitialized scalar variable
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: hariprasad <hkelam@marvell.com>, Sunil Goutham <sgoutham@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep
 <sbhatta@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250210-otx2_common-v1-1-954570a3666d@ethancedwards.com>
 <Z6rk3Z6TuFSJgSaV@mev-dev.igk.intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Z6rk3Z6TuFSJgSaV@mev-dev.igk.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/25 6:50 AM, Michal Swiatkowski wrote:
> On Mon, Feb 10, 2025 at 09:01:52PM -0500, Ethan Carter Edwards wrote:
>> The variable *max_mtu* is uninitialized in the function
>> otx2_get_max_mtu. It is only assigned in the if-statement, leaving the
>> possibility of returning an uninitialized value.
> 
> In which case? If rc == 0 at the end of the function max_mtu is set to
> custom value from HW. If rc != it will reach the if after goto label and
> set max_mtu to default.
> 
> In my opinion this change is good. It is easier to see that the variable
> is alwyas correct initialized, but I don't think it is a fix for real
> issue.

Yep, this is not a fix, the 'Fixes' tag should be dropped. Also I think
the external tool related tag should not be included.

IMHO have the `max_mtu = 1500` initialization nearby the related warning
is preferable.

Since this is a refactor, I would instead rewrite the relevant function
to be more readable and hopefully please the checker, something alike
the following (completely untested):

---
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 2b49bfec7869..7f6c8945e1ef 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1915,42 +1915,37 @@ u16 otx2_get_max_mtu(struct otx2_nic *pfvf)
 	mutex_lock(&pfvf->mbox.lock);

 	req = otx2_mbox_alloc_msg_nix_get_hw_info(&pfvf->mbox);
-	if (!req) {
-		rc =  -ENOMEM;
-		goto out;
-	}
+	if (!req)
+		goto fail;

 	rc = otx2_sync_mbox_msg(&pfvf->mbox);
-	if (!rc) {
-		rsp = (struct nix_hw_info *)
-		       otx2_mbox_get_rsp(&pfvf->mbox.mbox, 0, &req->hdr);
-		if (IS_ERR(rsp)) {
-			rc = PTR_ERR(rsp);
-			goto out;
-		}
+	if (rc)
+		goto fail;
+	rsp = (struct nix_hw_info *)
+	       otx2_mbox_get_rsp(&pfvf->mbox.mbox, 0, &req->hdr);
+	if (IS_ERR(rsp))
+		goto fail;

-		/* HW counts VLAN insertion bytes (8 for double tag)
-		 * irrespective of whether SQE is requesting to insert VLAN
-		 * in the packet or not. Hence these 8 bytes have to be
-		 * discounted from max packet size otherwise HW will throw
-		 * SMQ errors
-		 */
-		max_mtu = rsp->max_mtu - 8 - OTX2_ETH_HLEN;
+	/* HW counts VLAN insertion bytes (8 for double tag)
+	 * irrespective of whether SQE is requesting to insert VLAN
+	 * in the packet or not. Hence these 8 bytes have to be
+	 * discounted from max packet size otherwise HW will throw
+	 * SMQ errors
+	 */
+	max_mtu = rsp->max_mtu - 8 - OTX2_ETH_HLEN;

-		/* Also save DWRR MTU, needed for DWRR weight calculation */
-		pfvf->hw.dwrr_mtu = get_dwrr_mtu(pfvf, rsp);
-		if (!pfvf->hw.dwrr_mtu)
-			pfvf->hw.dwrr_mtu = 1;
-	}
+	/* Also save DWRR MTU, needed for DWRR weight calculation */
+	pfvf->hw.dwrr_mtu = get_dwrr_mtu(pfvf, rsp);
+	if (!pfvf->hw.dwrr_mtu)
+		pfvf->hw.dwrr_mtu = 1;
+	mutex_unlock(&pfvf->mbox.lock);
+	return max_mtu;

-out:
+fail:
 	mutex_unlock(&pfvf->mbox.lock);
-	if (rc) {
-		dev_warn(pfvf->dev,
+	dev_warn(pfvf->dev,
 			 "Failed to get MTU from hardware setting default value(1500)\n");
-		max_mtu = 1500;
-	}
-	return max_mtu;
+	return 1500;
 }
 EXPORT_SYMBOL(otx2_get_max_mtu);



