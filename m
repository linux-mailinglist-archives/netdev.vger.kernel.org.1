Return-Path: <netdev+bounces-68878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 768A1848A25
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 02:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E1A1F23261
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 01:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FE07E1;
	Sun,  4 Feb 2024 01:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PX1trNdl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E0110E9
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 01:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707010022; cv=none; b=mFl5a/MbFkcO3D0rnLLesQodSsKwFBt6TJSWp5DbJZusvHjKjPJs6gFSKiqG8cfht4qFRuTUs5Xd6tBF89NCOsGjuG/fU/Ks+AYjcOaKtwfAnRRQNGwuIZjbO8VLZMl9qcaOtCiMsrbRXsvdSL30TT9DACNbN+4f19TuGvTmBwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707010022; c=relaxed/simple;
	bh=EbHyPq/e8zmbhFVu6l6AuI8lO+YbCkSelDyByV6X9Ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JUftcwj7VG3c/JOlOcUUh92ACcluYulj5BlXvcWIo0O5zo9P7fWYT4nZAzSxU52tNr2WoiMotXx2PcG9Hx6WxU0Y6ua3Fw88wm4IE+y+Ij9Zwrb/oFtJ4FACriE0FOS2KT6JHPG6ks4ZwGc5spZU84ooXT987F33JX3/4NqGO8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PX1trNdl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707010019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S/5rSTh5O6+3Z8TDl9oL5m0EarOHPUjVQ3ykUHSjRbo=;
	b=PX1trNdlEn3cWHvNoKIEx6rUphe2lo9oNw/NzV8++iBT2XN5plB2piH5x7+nyGUczNd4oT
	+IX6rMdcYkIsN6K+A5M4wjO6+gwp3iUx0y5qRxiGycjmfvrfqDDpSgM7GoonRk4O5wYDCH
	xGZli9CaGhZt4qD0eeuF8/7y6OxK7rE=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-3qI4sGXDOkeomSZj85jqzQ-1; Sat, 03 Feb 2024 20:26:57 -0500
X-MC-Unique: 3qI4sGXDOkeomSZj85jqzQ-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-598b8e2b2bfso4839596eaf.2
        for <netdev@vger.kernel.org>; Sat, 03 Feb 2024 17:26:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707010017; x=1707614817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/5rSTh5O6+3Z8TDl9oL5m0EarOHPUjVQ3ykUHSjRbo=;
        b=aXHUAuaBk4nd0AR3u2P+GoVwpJQCIKWTqMri4WE4u8AR862QyhBzzWXCCgFhtVZK9E
         9BWisP+UR0kjl/x7i+9JlZgwoh4Va3LnQwzJKDp+9gw1tQMK0HxhJrWDCtIQycsGnypg
         fF+QPC5PJxdVw3PS1nWLf4Zv4wQIUlsfhO7p2r7qryTcbTvdOjQ+cENq8XR8hiAtNEwr
         N7aej7+NQH9ekFODZm8ndO9K6hakf22wTovWzsnAL0XeJDuaZp9Thg9S4P5ExyowD95+
         DZbizOlkyOJge0oJyFexyMubRdKa04JWtEnsDRDJ5XzCccQill+pO0MDgwyAdKN3sWiL
         uKTg==
X-Gm-Message-State: AOJu0Yy409t2MKjyE/zXT2a5GRFRzbWYITmrBOWWvIlR9A9URnDRtXcq
	elafc4ISkDEMQbsn3uJKD1DkwbRIz77lSSoeWK+fz60QrsBBeg1K49UID4B/QkQxGJNnZXUZxrC
	5DulKfrclPETNixFuY6S/xRkQIw1viYEvHqM7zHJrh+k29oJs65CXvqYDb0pVpu7uzCyolaOfat
	h81mVpu0BbJOE/fQXJzAETFsEK6yD9
X-Received: by 2002:a05:6358:6184:b0:176:5bef:d337 with SMTP id w4-20020a056358618400b001765befd337mr13013786rww.3.1707010016933;
        Sat, 03 Feb 2024 17:26:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFL7GUFwM4wvGQE/bEqw3pl1aZ644PP4TRzexyzf3V8ZcYDPON7gGZHdtKH0hUTcIPIgwoMq3wR8CVeEz3r4ck=
X-Received: by 2002:a05:6358:6184:b0:176:5bef:d337 with SMTP id
 w4-20020a056358618400b001765befd337mr13013773rww.3.1707010016618; Sat, 03 Feb
 2024 17:26:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1706858755-47204-1-git-send-email-wangyunjian@huawei.com>
In-Reply-To: <1706858755-47204-1-git-send-email-wangyunjian@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 4 Feb 2024 09:26:45 +0800
Message-ID: <CACGkMEvLOv9Mr5ayNxmuaJU_pHp0U2ND_BmKNYv3fDZvOjHnrQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tun: Fix code style issues in <linux/if_tun.h>
To: Yunjian Wang <wangyunjian@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, xudingke@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 3:26=E2=80=AFPM Yunjian Wang <wangyunjian@huawei.com=
> wrote:
>
> This fixes the following code style problem:
> - WARNING: please, no spaces at the start of a line
> - CHECK: Please use a blank line after
>          function/struct/union/enum declarations
>
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


