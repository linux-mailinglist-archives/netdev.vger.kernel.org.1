Return-Path: <netdev+bounces-114329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF54F94225F
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 23:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ABCD2855F9
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 21:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837DB18EFE3;
	Tue, 30 Jul 2024 21:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IB5pgjF8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20AD18E02B
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 21:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722376482; cv=none; b=YulWc6OsUVtS4MWOJ/vkq/A5aTUZi8qJyrk8bAN2sP1FxbI2Xgp/mOPmnypxdFzsluSCjgrbhzT9JhG9HDYzmVDZgKXqKQ6OnYck3JiVZa2tszK8jcx/SMEYnC7tp1dtER5vBwHvF0NTLVAa4AxYZlTCpXL9j++wzWp/K7WmuhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722376482; c=relaxed/simple;
	bh=xFNqKNUZC3QPbCH+2C+qGCkgqdGmxd4GGQWFBPEVmcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkTyFN0kOvF0IdsUmkx15SV4nWnLaeaE5kVmY5/polRNHdXkuFmavP/6hkkWEC1qEYsoAI4tHx5i6ON/nqERaGzycrVBtWcaPAEP26uxjJ7LfcYXl9mi5Di+pxElobsooixqtUWLfv6KsMIhTcSoH6aBTZ1SwZKAfmL5UZAq/Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IB5pgjF8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722376479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XiTAbji70C9FYBLGjSmfVHzEQNNemDMhCb/cI468cQs=;
	b=IB5pgjF8qrXd+y9toOmjyn+tHNf+65YeNYozfWElwd7Xw9nuni0Eywb+uJ/cXYlvD6aido
	ZbpjPv3kndEl6DvkJRYpGo8ChBakHHhVSa7cvIVVBbrWu46mDMgXsrPVZAdxhiaEU6+/34
	VbMybLLlRLRPcgtPTRqOD7E1G4RBf+A=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-q4qx5jzUOI6tJLNa9dmuTA-1; Tue, 30 Jul 2024 17:54:38 -0400
X-MC-Unique: q4qx5jzUOI6tJLNa9dmuTA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5a2a0e94a66so5139846a12.2
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 14:54:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722376477; x=1722981277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiTAbji70C9FYBLGjSmfVHzEQNNemDMhCb/cI468cQs=;
        b=Tli9flGyQxZhMRUYmIuSGb7+G5fMvt80BYf+P2S25yENSXLxwuBgGAwUk/UzIadbAN
         sfLrqH1OyACqYfmszGQ5q6fq3DaTX6tzjokx+RvkS554oCTcO/QAu4Dgy6LbCBJO/kB5
         eNL89zXlQGGCKINCcbarGaggu/xXD+2/Vo/rVcLOdM6AMKbYVufa7daROf8IwZO9xbeT
         hVq8ZjVs6jOCbpMzjnqlKIYkeyaHaYMC7Qz8PJTU0vZIVZGgPCr8+GqNn4NGDnZBn4Ex
         /bemCN1yO8f+g544ApZZcEd4AMpddV+hCJdi1Ikz2ED2GZPmo/WDMRsHgVW361QcuQ2N
         E8zg==
X-Forwarded-Encrypted: i=1; AJvYcCVgyew0qaYGhR3flsYSdN3Hn81GG0PJniNlQoXGUP7gsq2LG80b11CJS/yK+TkQUnSz7EIoKHh0QJVz8lFGp4/LHv8inQvm
X-Gm-Message-State: AOJu0YxJhXtT27J9wbABrwSl+QRzuADw553dgBnKvgJx++VfRIiG2DsH
	bHB/7ILZqnbIap1UVq/C4XMCA87olY/G19ReV9fNlTGg+Y/tby+C739fNcDIDQr2ycdn1HHh/sI
	l+uAQaT0CWHfn5rKKDVsHkUJIRAURAVv3CVyLvzNyl2rWjnNlgvlcZmSR0H4JCg==
X-Received: by 2002:a50:9fc8:0:b0:5a4:6dec:cd41 with SMTP id 4fb4d7f45d1cf-5b021d2231cmr7849775a12.28.1722376476796;
        Tue, 30 Jul 2024 14:54:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBAMnTW+0ZR0faIaLVv8dqaI6j7fVqABVL6hy1VheVczujzgMg8WoKj65x/wzQERyVgM9dXw==
X-Received: by 2002:a50:9fc8:0:b0:5a4:6dec:cd41 with SMTP id 4fb4d7f45d1cf-5b021d2231cmr7849761a12.28.1722376476162;
        Tue, 30 Jul 2024 14:54:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:d5c3:625c:d5f0:e5f4:6579])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5afa605d81bsm6216832a12.74.2024.07.30.14.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 14:54:35 -0700 (PDT)
Date: Tue, 30 Jul 2024 17:54:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [PATCH v1] MAINTAINERS: add me as reviewer of AF_VSOCK and
 virtio-vsock
Message-ID: <20240730175120-mutt-send-email-mst@kernel.org>
References: <20240728183325.1295283-1-avkrasnov@salutedevices.com>
 <20240730084707.72ff802c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730084707.72ff802c@kernel.org>

On Tue, Jul 30, 2024 at 08:47:07AM -0700, Jakub Kicinski wrote:
> On Sun, 28 Jul 2024 21:33:25 +0300 Arseniy Krasnov wrote:
> > I'm working on AF_VSOCK and virtio-vsock.
> 
> If you want to review the code perhaps you can use lore+lei
> and filter on the paths?
> 
> Adding people to MAINTAINERS is somewhat fraught.

Arseniy's not a newbie in vsock, but yes, I'd like to first
see some reviews before we make this formal ;)


