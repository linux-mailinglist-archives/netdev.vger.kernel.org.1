Return-Path: <netdev+bounces-154666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4729FF58F
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 03:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A9307A1183
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 02:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BB54A18;
	Thu,  2 Jan 2025 02:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NlnnJvCk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5F54A00
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 02:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735784319; cv=none; b=I5T/WNckLUA8qPOt+UFCmK66y0diLPg0k9aY9h53BVVOZiQff7V4AMhZk4GBOnhfZiPQQdBs9oONb2eTeUx/j+hLbLz+N35erfiQDx1hS9AUmINVotN8DgBhpMzD6QVg5elQrQF+U13v8p/etX8sPAt2YNZbAKAc7kPnCXZFXZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735784319; c=relaxed/simple;
	bh=QC5FSatEYmo6AysA4Ou0OTIMnH1qy7C/SgrN1QAj3ZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8XFjrgdK7yA9yUAB52UwKJERsQwYhZNlgu21vCzpoL46SBvURCuMAcvvdqZX3aBm9M+Y5TcVsAV8pHP03Fc4uNESn1999jM89l4a0sE7Zd1hre6BVMSCME5DjpQ/ZvLF+wfC5w/0Qr7A9hz30ZdkfvfjDiXbqZ2V2Mx9A47WoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NlnnJvCk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735784316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QC5FSatEYmo6AysA4Ou0OTIMnH1qy7C/SgrN1QAj3ZM=;
	b=NlnnJvCk9A0Crq6AcAZBXcjPWLcKYvLyF09YW9WqvRcie/n9So7Kk/HSIp6xS4e7SEXvrZ
	4nEg02waXXA5aGaZlUre3+B9VKJvNPLCfPEkJ8te0UwJ3HNBC3uLtheZihTPMX8btXHrgt
	Y0ug0PGBvMz5wkdGXNyLS6meI0sj3hQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-QmHirGILPxCN-W1a594zMw-1; Wed, 01 Jan 2025 21:18:35 -0500
X-MC-Unique: QmHirGILPxCN-W1a594zMw-1
X-Mimecast-MFC-AGG-ID: QmHirGILPxCN-W1a594zMw
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef9864e006so22663733a91.2
        for <netdev@vger.kernel.org>; Wed, 01 Jan 2025 18:18:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735784314; x=1736389114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QC5FSatEYmo6AysA4Ou0OTIMnH1qy7C/SgrN1QAj3ZM=;
        b=bIwaQPy9/mEBOnlwtiIx6Nel6eZurLkrM6jLJHrwWuGGANydfjWzSl8v5JKvvq5s7q
         lQpbVaamW/SfhAAczUroN71wm6KD8jMWzAqMLblY8KQoMkK8V3CG2C3nIfAv465CcPPs
         /CFqmN5vb+lONm3OY9CtInPQ8lis+eXsHpnulu//oHEQ94nEPKYgcNgZ77hfkF+HsI4H
         Ue1E++vfnqDbTLzHQjXTRg7gvq2fnWg/gWZTAneEge7OvHwso1Jy0iFIy7Q4QukRG8Ns
         E0bFA2DKljp8HgsApzzD0Wcau7bUykx2AkbVWr4FgJ0Rjb5SGkymO72CzsU361Zuan6U
         6eUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4tfn9sZwAGjCQ+gbwxuswEWSPQDPdoVUXVUn8VOV6IjjVjPR10XUPgbyu6+1tHTFPbsdxaDE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1XnhiNw6ftNq98BhQIiOL8tUKx04iMDMtdvM/KWaw79i/rKiP
	1JOIeXY7UpeznavdsWUCfMxrRZHmliTBCCmHKg+fLaTYqn5enMPSAcnY2HAa0C3K8SM7BD9gU2t
	jJiT5ng5oLoyVFTJrzZrX4z8I+GhrD29/PP1otJApQOT3K1qOxpSSeNAPHVuCXkiJtjXJ6deQDN
	mSwWYspgHAY750NHASv3gBTY/GDQNo
X-Gm-Gg: ASbGnctzaEQy7HHmUHz40V4ytjjO0UG3MC6G+/Is1fy0dnuVx6nlcerRQwYYWXDMcyr
	dM9KQIDm9cXGnu0MLSgU2iQnADjM0XC4Mwn9BbD8=
X-Received: by 2002:a05:6a00:1944:b0:71d:f4ef:6b3a with SMTP id d2e1a72fcca58-72abdeb6e80mr64384021b3a.21.1735784313828;
        Wed, 01 Jan 2025 18:18:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTDDT70rbUh8ytd2/vFAmFqT3HYe901ZEXvYhNUOvpAQ4SUsh1N+XXsejGmZK3cY/fZF7jnk8eegPa1zVpxJs=
X-Received: by 2002:a05:6a00:1944:b0:71d:f4ef:6b3a with SMTP id
 d2e1a72fcca58-72abdeb6e80mr64383992b3a.21.1735784313301; Wed, 01 Jan 2025
 18:18:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241230124445.1850997-1-lulu@redhat.com> <20241230124445.1850997-2-lulu@redhat.com>
In-Reply-To: <20241230124445.1850997-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Jan 2025 10:18:21 +0800
Message-ID: <CACGkMEt9c+KPuLTUA4YG84_ejo00NC8MH3LMXcTz6pXxABRNYQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] vhost: Add a new parameter in vhost_dev to allow
 user select kthread
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2024 at 8:45=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> The vhost now uses vhost_task and workers as a child of the owner
> thread. While this aligns with containerization principles, it confuses
> some legacy userspace applications. Therefore, we are reintroducing
> support for the kthread API.
>
> Introduce a new parameter to enable users to choose between kthread and
> task mode.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


