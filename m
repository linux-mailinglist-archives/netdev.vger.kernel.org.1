Return-Path: <netdev+bounces-168872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0A4A412B6
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 02:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AAAC3A84E1
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 01:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3FA2747B;
	Mon, 24 Feb 2025 01:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ifKkOx8X"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62051078F
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 01:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740361204; cv=none; b=ANo1etsCu8PusR6H9uJEykz52Ct/TQWPdgLcjcm/WN4dOyVx0O9GF0rck35nABN2o7IHOm9S+vlThwW8O+570UrLnZb5FHxfQ830UQDBpWj5bRe/KjrC/b8CXN2KNdqoribJqnq/fgua+2yZcu1ZY0V2KSlJZsCS0+ENN9O0Ilw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740361204; c=relaxed/simple;
	bh=nrfskPXfZaYSBul35BNpLO2cF/gkFhdjabAqJfP6oJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H0Geu56rv0KTIyzHoLCkBXvMcUp/iAA28lkiuycAIzE/NpMZDwttvn6HNbRgSKOp+A39JHgmzTiq9aHs4Ejhb2CqwGo4HFEnd81NXkZviJEhH35kGran0oxCBZ/Wmsoed00JbcaBpCWCGfusbJXv7aXvcwhSqWmn7wJgNR7HPi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ifKkOx8X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740361201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nrfskPXfZaYSBul35BNpLO2cF/gkFhdjabAqJfP6oJw=;
	b=ifKkOx8XZvf5O8PqunE/w2vo/0hEnYOyMmg7EKDcGZntd62gouvhIM2ALncTmnzm4cc6yR
	VQG8idLGtkrMPSg/ITNx9HGKFdj8kb13ypiK5hCNsPypAbD6Uy0xUS3UT2DvftWAp+bKki
	RYr3iW6kW9T/z1eY8GlhexA8RFvRPeY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-HqmrSD5nOQaaCmU1ruxEHw-1; Sun, 23 Feb 2025 20:39:59 -0500
X-MC-Unique: HqmrSD5nOQaaCmU1ruxEHw-1
X-Mimecast-MFC-AGG-ID: HqmrSD5nOQaaCmU1ruxEHw_1740361199
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fc0bc05c00so12872366a91.2
        for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 17:39:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740361199; x=1740965999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrfskPXfZaYSBul35BNpLO2cF/gkFhdjabAqJfP6oJw=;
        b=KboTDYtw26xMlJ86bKPHBPS7sJ2ToppGZB6H3cV908YCtiw/sA5rVbD1wf12zybmP+
         08g3rWhgr/d14Q/07dzPaMyaquPU11OsayU+NKWUKpdO+BwCtmrRmpmdschyDvwDrMJ3
         FnwgMMt50OvNu5Y5j5z4hWws97fjp7PecXzwMWaQ1TbJMbkDtGBNXu6cjeMFv8HD5QJ4
         OpKNfWtSpg6Ye4gFBw/RZTye9cPVao93S8AMZtW7V4oU/e48V/vcAzqJV/L4UBZ3clb5
         yyZGOjGaG9+V4LAx1JtRNaHWmW6C9xH2RKbKfUG+2EIvMlDiixLPZp6OFyWGpoHMs34l
         /efw==
X-Forwarded-Encrypted: i=1; AJvYcCVUkLHNOhP4WoJVRJjkZWHYPHEW1SINnwsuiY1hTKeULJkRTfQzuj1dXOAtu6jmCCmFZKyL3PM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYqMb5Fail3j+A591yCiO5dbh41bDg26djCHO4phONqYiuWZry
	a/X5NRfra+pR5PPaj9vhaKeMR+wtHyCxUyGChTd60moxT8wjUUlWHdG32ckHnku5C3CL0EfiaTD
	ApVsv9qHpXM6gMcIdYs+31WxWWAnUX1oEJG3ECAxUT0Sq42V7JFX/ihAuh3BVQiCGL6ugIwA7fN
	AVUz0rhJGlgZRX7gSelR6aMTYENptu
X-Gm-Gg: ASbGncuHSnWF2IbrGUaHN2Z1rDkPlkCMpEuaMzO3KjAK+3HVrwd/TyQcrftHrZD//Ma
	f8uZ9WJvnLHFoNkb3Q5UxB5gKC+fk9W8NlYOg8lpLtC0cXOVIyidIPr367Wnvu6tzRPbynNG8tg
	==
X-Received: by 2002:a17:90b:1a88:b0:2fa:2252:f43c with SMTP id 98e67ed59e1d1-2fce7b2c06fmr16130626a91.34.1740361198912;
        Sun, 23 Feb 2025 17:39:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGONcBxFR0n13Ho0Oz96boeVVOYPPhVCv5Oly5cUz/HAY7eIJGFtWgwnxADw9SLiWOkHbcKmlHWn6DR44VUsY8=
X-Received: by 2002:a17:90b:1a88:b0:2fa:2252:f43c with SMTP id
 98e67ed59e1d1-2fce7b2c06fmr16130601a91.34.1740361198521; Sun, 23 Feb 2025
 17:39:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223154042.556001-1-lulu@redhat.com> <20250223154042.556001-4-lulu@redhat.com>
In-Reply-To: <20250223154042.556001-4-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Feb 2025 09:39:46 +0800
X-Gm-Features: AWEUYZl6q3WmzRiZ7R6AyPCTyXoGgL2WiDIIupnXJ0sHWiJQL0PPi6nbPrX6XJg
Message-ID: <CACGkMEt7bkpOXNff6Ve+3nR0xN=zzjm7qZNsZOV2HcnuGvVgig@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] vhost: Add the cgroup related function
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 11:41=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add back the previously removed cgroup function to support the kthread
> The biggest change for this part is in vhost_attach_cgroups() and
> vhost_attach_task_to_cgroups().
>
> Reuse the function __vhost_worker_flush, but in this situation, the
> attachment_cnt is 0. Therefore, add a boolean to disable this check.
>

How about just tweaking its value to INT_MAX so we can avoid this new param=
eter?

Thanks


