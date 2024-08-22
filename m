Return-Path: <netdev+bounces-120794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CEC95AC3B
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 05:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDC2281772
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 03:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7A63B79C;
	Thu, 22 Aug 2024 03:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnUtvUZl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F753B192;
	Thu, 22 Aug 2024 03:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724298357; cv=none; b=EEpV7HdNZTX9soaU4SVUZRkn6BTabMueO50dsh9heNXqITW2qhL9busoq+dbWwl7ojNraq3Q8iQAnCWY4zyoZ9O8GBEqXzPcAes28aDufOHqrSIPBFPxOZc3tahgl9eOK9qHh5PhWsLami07YiapvwhZG3w2B5xPwq41hwWCVZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724298357; c=relaxed/simple;
	bh=+7uLR+UBXmRfIR0m/59Lkz2AG+LLfT53KV1lFtES6kE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fE4G5570vfOBV91xqPuwvqImCW8Xnk68QqcASwvk5jYH7cy2xx4x39poRE1ldFp767fDQmjZWI4mEOXC5PRaOxYWtXEtvvGC011vG1FsZJdDnyzAvnxljKsY9FQOKz0DcAheNrZ62ZiLvaSJ5tPiuMxWT0TuMly6qmR8IRQnSTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnUtvUZl; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6b4412fac76so3710207b3.1;
        Wed, 21 Aug 2024 20:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724298355; x=1724903155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGzmkhbGckFP/y38PBeh7SnOL9LzvUwcTAANH9fPtC4=;
        b=fnUtvUZl28T2gSWsDBwzmgsXNjVIZHJnTF+8QkV+WX94hQdZy/W+uM4NYH0anw0rtR
         lMMFBQV9frG1UneiOG+Ju+Uhrr+z9HV7ANDYDmqEa3QxuyP6QES1RzuyeNzSTcfXGCgN
         DJ6HIEWuJ2xFHkuLGtKLejKVr/SIjcOQfE+brh/u1Mz2AtfPBI09gIQf5FGxpWshnsKt
         KVhAz5WQJMj0nFH9VFoSbQQzKETAfnu1ku4IDli7szX7nohqJakq3bmqjGMzsNom4lbZ
         JumNcCDzQEGVixl52lxppQuMR5J/603+8u7CGuYlhonQKDV01SegDtm904GNm0hF2uPv
         qpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724298355; x=1724903155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGzmkhbGckFP/y38PBeh7SnOL9LzvUwcTAANH9fPtC4=;
        b=GfgOVHM0TqCXnsqUfIyuIWNb98Q16YhVVTKV+2fCpAQNroWgSuJmBIi0IoHf1Wd/Jx
         TBmnhNo7u2ZABXNag1zHcAWZD58Eq5FDUHq2A94kFw8yVRbKfw8xlwuOl6fv8rX7CmMX
         PjJMtlVqI6OifetJaHSp8H2xXfh8CM9hGvt/23aGgBvHeHeS3QHVKdNMpdDSugoMMRUS
         UnPPx/+Gix6snz8zP7aKY0gQn24ZlVm2hnDPLJuSCYVLyVDXGylW2IOzWbzeyGX9HbF1
         MlgU81LLlTmot/f0iSuGG+RId/un6K2pGkirIlxRHKj1Qn8ZmOwfCBTT6rRbnVMVG+uA
         yruw==
X-Forwarded-Encrypted: i=1; AJvYcCWANVHnLMaU8T9x9ORLvNlrOU9qbam+1SwxIb4HXXMsZ4TGQ4XUDmyG2TirAh4pJU5I40R+YuQk@vger.kernel.org, AJvYcCWqxk1plrV5cN4nEVbRyI8Vq3AEr6oVeJh7U30rHv89vdazgzi668S4dYW80cDGRCbS9wosydis4G+AhTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKtrRLKaMOOqkj5WmlkxKCmXgLDu1ewcqgGytSxr82Lq7zWRnX
	ILIbdWgok1gzUfm5w//gUHcCelERvIi4n6hCNCwY1LnUvZ2TBb8ydoOP3TC1XXMbfUR/VWSIr1w
	WITqz8qJMuTGlsK9OOXQGLCwW2GQ=
X-Google-Smtp-Source: AGHT+IE8ITH8FXL+FbdqS6mpsyawHDXEPhV0yVV7Ud/cyt/huwSk4+VJRES1N7aqLriTNiwAWDaTtQSc65yxH9WjzGU=
X-Received: by 2002:a05:690c:5241:b0:6b0:407a:e3af with SMTP id
 00721157ae682-6c3d54301b0mr6230437b3.34.1724298354779; Wed, 21 Aug 2024
 20:45:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819122348.490445-1-bbhushan2@marvell.com>
 <20240819122348.490445-2-bbhushan2@marvell.com> <20240820153549.732594b2@kernel.org>
In-Reply-To: <20240820153549.732594b2@kernel.org>
From: Bharat Bhushan <bharatb.linux@gmail.com>
Date: Thu, 22 Aug 2024 09:15:43 +0530
Message-ID: <CAAeCc_=Nmh25RDaY4SA2CHsu2mqgdtKEo62b4QKSV4V8icHMMw@mail.gmail.com>
Subject: Re: [net-next,v6 1/8] octeontx2-pf: map skb data as device writeable
To: Jakub Kicinski <kuba@kernel.org>
Cc: Bharat Bhushan <bbhushan2@marvell.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com, 
	sbhatta@marvell.com, hkelam@marvell.com, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, jerinj@marvell.com, 
	lcherian@marvell.com, richardcochran@gmail.com, b@mx0a-0016f401.pphosted.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 4:06=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 19 Aug 2024 17:53:41 +0530 Bharat Bhushan wrote:
> > Crypto hardware need write permission for in-place encrypt
> > or decrypt operation on skb-data to support IPsec crypto
> > offload. So map this memory as device read-write.
>
> How do you know the fragments are not read only?

IOMMU permission faults will be reported if the DMA_TO_DEVICE direction fla=
g
is used in dma_map_page_attrs(). This is because iommu creates read only ma=
pping
if the DMA_TO_DEVICE direction flag is used.  If the direction flag used in
dma_map_pages() is DMA_BIDIRECTIONAL then iommu creates mapping with
both read and write permission.

>
> (Whatever the answer is it should be part of the commit msg)

Will update commit message to something like:

Crypto hardware needs both read and write permission for in-place
encryption/decryption operation. Iommu creates read only mapping
if the DMA_TO_DEVICE direction flag is used in dma_map_page_attrs().
Use DMA_BIDIRECTIONAL direction flag in dma_map_page_attrs(), so
that iommu mapping is created with both read and write permission.

Is that okay?

Thanks
-Bharat

