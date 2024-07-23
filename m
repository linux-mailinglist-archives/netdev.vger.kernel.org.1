Return-Path: <netdev+bounces-112504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FE593998A
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 08:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873DF1C21646
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 06:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD08413C90C;
	Tue, 23 Jul 2024 06:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5faljS2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68277632
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 06:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714571; cv=none; b=dhWZZM6YYw70Krjp2KAELgVvXCc3TguSR3+c8idygVWBFD/Ej94pb8Ewe5Ym0uMtH6Ui5P2ckV+In2gsaMGbmD7Lq846sB3RaHeJ0Nfv1X8xG5EFKrs55WoXXdEK2gR7OA1NpGbSY6yd4Gt3F+jzkRvITlwkn5mdvAfLVIZXPl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714571; c=relaxed/simple;
	bh=xY4Nr0ZV/G5xCs74taELZsVvfH8f1KeA8L+JBKvR6NY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fK5w1JhM2diYHUHDQJ8DCOrYzZbp/V6T1515GRPwnZaqntIGkFg+xxFL7LXW844UnIK1sl9WNAQCdVr3CGErogduGCfP5f64qCFdSuteGticRt4H4etbIVFH20X6j2llZ5C9RD7vp9ACGZklyXi7/d22oS4IwpPQFpIn42VqgaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y5faljS2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721714569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xY4Nr0ZV/G5xCs74taELZsVvfH8f1KeA8L+JBKvR6NY=;
	b=Y5faljS2bndwHZpNXA/lhQBQ1chKDx8labmkckx42zRw6Y1ghk2E2HIeL+rWb3WPD7Fnzr
	NVPMdBstdTCOHraNla2Nrm2mO9KlRY9iKla56cgZW+ZNcEZX3H7LnHX2AJEuqBMhfuik+G
	QC0zRIpGUDhvxt0WHJhm/Z5LepST2Z0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-4l1YTR2eMq6BWAcbW_6X9Q-1; Tue, 23 Jul 2024 02:02:47 -0400
X-MC-Unique: 4l1YTR2eMq6BWAcbW_6X9Q-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2cb656e4d97so5826629a91.2
        for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 23:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721714566; x=1722319366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xY4Nr0ZV/G5xCs74taELZsVvfH8f1KeA8L+JBKvR6NY=;
        b=NvZFFaQJCMSMZPfaAz8VVEDRDpvgoAVG0/pos/bnRHXqjJGiZz53S5c3aLiENjA4n9
         tiGyyGblJszV0Jbv12R8x3ZpG3JO61WqvWCIQRRwwK6daa0u96WfmeGYNTTqptr4+RTl
         uBmVF5O/3X1M5ldgBp9tEDBmalq58peikHggARl0QuF5b++C8lx/TXF3rHepBfRzfy+W
         8CCR2Ae8JJA6IY4fKYco4bOLwjt9M8qyPT7TGC2G0QltUH+FQ8SXQ4SDAO0Lsjpkt46+
         WU7+c8lRezPukGaEnxWq7T2nxIttYhdED6idm8qOey48u6bmhpcRuYWpTaPmIzjpPmaZ
         +X4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmomRPOPFkWM9RusIcbiJIrqR/K4jFTEsHUqTYCn/ziigBVOUh4Jp+MIbSnRnKHgVjsa3A87enrtbpzMBYHOivJdLyUZWc
X-Gm-Message-State: AOJu0Yw7KpNsALOEGRHD++c9B0Q7LFYGeHT0SgZWs780St+OPou0Mtru
	v8RSqUeac2a30P87bJLez4S1C4J6KcUz99W7TERDsPe2AnQgfi4DQXbAdFUF+Sou6WpTWcF/j46
	PvoUdj3I55/JGDNhzCzDHP664BC0syfxpa6sQ05USUl00Z5SiZkpp/kvcZPgpcC52HJUxFex1nP
	5l8tZtSblcs/TUZnvWyELLYFpbuJ+f
X-Received: by 2002:a17:90a:784d:b0:2c8:6308:ad78 with SMTP id 98e67ed59e1d1-2cd274ade5emr7793406a91.34.1721714566592;
        Mon, 22 Jul 2024 23:02:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdUHj4K5SDJj0vjuTuGZn7pj0Rf4szKIkdJfWXa0Y2D9tnc4NJZo92YMqIKXjSmlcTOB369VIJKPiI+kROhlA=
X-Received: by 2002:a17:90a:784d:b0:2c8:6308:ad78 with SMTP id
 98e67ed59e1d1-2cd274ade5emr7793385a91.34.1721714566181; Mon, 22 Jul 2024
 23:02:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723054047.1059994-1-lulu@redhat.com> <20240723054047.1059994-4-lulu@redhat.com>
In-Reply-To: <20240723054047.1059994-4-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 Jul 2024 14:02:33 +0800
Message-ID: <CACGkMEshJ+nKvoiY+P0Xg_A09D_jsEU690y08TY7jkpMLoWeyg@mail.gmail.com>
Subject: Re: [PATH v5 3/3] vdpa/mlx5: Add the support of set mac address
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 1:41=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the function to support setting the MAC address.
> For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> to set the mac address
>
> Tested in ConnectX-6 Dx device
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


