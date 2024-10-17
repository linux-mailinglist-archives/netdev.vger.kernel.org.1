Return-Path: <netdev+bounces-136740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D58AA9A2CE8
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 20:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF301F23315
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A87A219492;
	Thu, 17 Oct 2024 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPjTIZQQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958131DED44;
	Thu, 17 Oct 2024 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729191549; cv=none; b=gpVwC4MQCDTp+3EyIfxLN1qvWrEk0rcfs5SdIYJrDCVXGxhz2sAHDylRHnSJfrFGVizfl5TPj3l61b5s6wIJZYg4/Bc7mzYF4vVWmLjaYrme6boAXTSHxsNzpsu3hhK64eLt7z8d3Tr1EZCZxtU00evg28XXUkvb2RfHEyw4OOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729191549; c=relaxed/simple;
	bh=qxt62waTB3PDSo3NWAZ+qP15HTZ0l5O0d2ezGw66NBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLeXxrsLIDTt6oq0OgsA3o37N7WC8Tu+AnwPC9pqQnGP9Pe/x7GISSYq6T5kqO89EXfDGklAxmHgVYDM5Kms8I1YyA3JDUvzlMBmrf9R2I1xJToJVgSk0SNZh3MkDq6lxwzKDSrhuO2lyWaCuiHlHWuMKPMA/uCU0uoA07/x5dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPjTIZQQ; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-50d5795c0f8so361349e0c.1;
        Thu, 17 Oct 2024 11:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729191546; x=1729796346; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/c4INpe+MfVSEagif+BSPExCJb+0PZ6F2m37aPw+1c8=;
        b=KPjTIZQQRhS3Pz7/PB2MEfxXQvGpAYDi5eMCiMz5mR+nxtF/oUQgqtVIMRXnrjY991
         iRnL0CbUU7ZyufYCwBaWCcUYF8cGCVvNtqqBSFdMQlTfO/B0YhFfLUmzmjb66ZeKj2Rb
         T8isv5YfZ/M5t5gUqPG3VT7A5i3pEHus4ewR5JfF2q0ORnF771Jvi8pXw801bVz/B1gU
         utkdRYbFaWkyHXrjZsdp890D4BzWO9hcwCBN2YMDYht2i5IdQSMuBINcT7itdxjqFsog
         BR46CdYCd8Qh4hsNdny2wRywLkj5b8mdFcqMtgPSk/eg/3rnN8y1Ou5j2sInNsA1GsWc
         iP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729191546; x=1729796346;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/c4INpe+MfVSEagif+BSPExCJb+0PZ6F2m37aPw+1c8=;
        b=F/XNxuZ4vk9o0rf4wKxnLBFHY/CzDPVz8cMkxhr6dgoSkKLf7AZxFlj7T0RhtyMfgN
         GojV3LRtkwDM3UzJJJAkG9VKEgxq3su+yz6sCrMSneX+i4n9YkLrIgRWX7mSd8dgWxDK
         fy7ftioq9Qk9xecTZgDOitw/HvQqC7pbu9JGsmYEa44rfUb0+QqIedTGXA5XFlT6jM0U
         bcjCrGc8B7ULUgvafOdIyNtdnHo3bEMsUqHXNIXQ3hiUjNn2M3zB6hMn2lWulr8HvBOH
         tIF6HWTEwmgK4HIhE+csQL3nhIOSi89DjxZ8F/tTi69rKkuzjFEK9c696Wln58GsKNsS
         Qv8w==
X-Forwarded-Encrypted: i=1; AJvYcCWhAViKh+cWa9ub22QwcJFVbFH3RSXooGPeq0zlOXxVmPhuxzvB/72uj6MF2cwjBgu0PltBQydN@vger.kernel.org, AJvYcCXBhtIuW4fNczNnlT9TBxMegDo0V15ASD9n13JCKNx/J/MmY0uv03va9l+8fR9tQTRWde1Z94ISyqH34mM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcr9QY16l8oqdZK9pTWP6ihkciBY677bA97CBeQa9wfg/fNYN1
	814gMniSSVArQ65QhKjQ4O4WdRSgHYv/Vk6L33u80ZpnwF1fodZIS5zK3OtR1Swmy96zuv5lkKz
	6gs1qMlAkJ27/JrJhqFzpEAU9wFM=
X-Google-Smtp-Source: AGHT+IGjhrP0HcKSp+hcs9KUfIwkUCljEr0RJ7I1+/iVXuotSqh/+b0bPduJ8iGUe/rQCda6dzcwbJ6xxoIKdwavjDY=
X-Received: by 2002:a05:6122:4592:b0:4fc:e3c2:2c71 with SMTP id
 71dfb90a1353d-50d8d2122f9mr6769677e0c.2.1729191546334; Thu, 17 Oct 2024
 11:59:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017185116.32491-1-kdipendra88@gmail.com> <20241017185636.32583-1-kdipendra88@gmail.com>
In-Reply-To: <20241017185636.32583-1-kdipendra88@gmail.com>
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Fri, 18 Oct 2024 00:43:55 +0545
Message-ID: <CAEKBCKPmRnpNGGws2FvmGCw5wnK+OvkyQzYYRJ+3JypuLp7OWA@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_common.c
To: Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, 
	Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.cocdm>, 
	pabeni@redhat.com
Cc: horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

+pabeni@redhat.com

On Fri, 18 Oct 2024 at 00:41, Dipendra Khadka <kdipendra88@gmail.com> wrote:
>
> Add error pointer check after calling otx2_mbox_get_rsp().
>
> Fixes: ab58a416c93f ("octeontx2-pf: cn10k: Get max mtu supported from admin function")
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> ---
> v4:
>  - Sent for patch version consistency.
> v3:https://lore.kernel.org/all/20241006164018.1820-1-kdipendra88@gmail.com/
>  - Included in the patch set
>  - Changed the patch subject
> v2: https://lore.kernel.org/all/20240923161738.4988-1-kdipendra88@gmail.com/
>  - Added Fixes: tag.
>  - Changed the return logic to follow the existing return path.
> v1: https://lore.kernel.org/all/20240923110633.3782-1-kdipendra88@gmail.com/
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 87d5776e3b88..7510a918d942 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -1837,6 +1837,10 @@ u16 otx2_get_max_mtu(struct otx2_nic *pfvf)
>         if (!rc) {
>                 rsp = (struct nix_hw_info *)
>                        otx2_mbox_get_rsp(&pfvf->mbox.mbox, 0, &req->hdr);
> +               if (IS_ERR(rsp)) {
> +                       rc = PTR_ERR(rsp);
> +                       goto out;
> +               }
>
>                 /* HW counts VLAN insertion bytes (8 for double tag)
>                  * irrespective of whether SQE is requesting to insert VLAN
> --
> 2.43.0
>

