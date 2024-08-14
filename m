Return-Path: <netdev+bounces-118321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9709513DC
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 07:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2531F248EA
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 05:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0C86F2F4;
	Wed, 14 Aug 2024 05:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HkyYEUW5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35DF6A01E
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 05:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723613022; cv=none; b=rbXfQCMYWNU2xvF5EATrC0+T13B3aodkabq2xxhlYrL/yzMXm0Yu9qVVc/QcKeDJ/aFlZJ6FkZZ1Wb5G7tHvZS+q/9RbPuFzJvjuwOd2fsNLRbejobr2adTZBu3GdP1t2BD2aWn9VqgBy08z16yJb0GXmPUtnxA2arId/18gJmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723613022; c=relaxed/simple;
	bh=7Gh/M8Zyi+t+eXsvHhqy4r72SOYBFck1SgwYl7QpDkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUc3sPPrZqj0sBk8wQkzmuOrVQqLS3TrybJNKKMp6bz4Nqz4zQAUTM1sEX4wnOV1drRtR/+yz8ZTcUxV4kv9yQqLqFw8Q8VfueGzHlHdnFuYTBqznUbHT/PAZ4Zld9Zw4KH4D07GCdT/f4twQzbgOYZOc5kALttgmkNRh03x7as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HkyYEUW5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723613019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Gh/M8Zyi+t+eXsvHhqy4r72SOYBFck1SgwYl7QpDkI=;
	b=HkyYEUW5osLqsxHCp/kX3lIq4qFE0Dokwyo0u0DdD4JmdE2UOdQ4/1MY9hV5AtIr5v1e+q
	ySkhLByNFQ6/mhYh/dwZS0qxyVTTCjcBFLyiGqPy1zDVGy4LrblzsWkIRVGCoidoMo6JPH
	9RysIl1lsh0hRwsV1DE25B1dc3ohit0=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-QCVxA4E7N8mVMuXzDdoObw-1; Wed, 14 Aug 2024 01:23:38 -0400
X-MC-Unique: QCVxA4E7N8mVMuXzDdoObw-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-6818fa37eecso6141769a12.1
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 22:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723613017; x=1724217817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Gh/M8Zyi+t+eXsvHhqy4r72SOYBFck1SgwYl7QpDkI=;
        b=gxkB4PTUXY39SvpaMV7MkdSZX7lSXRVI0GRkdKcoFUwwM5spUR4FtPxuMK1PORRDkP
         TnyxQT+fWeahqpNDuGYY2zev4H9/eOlQhECeSXC90onaCqEc4DSneFH/ShsnToDtaR9E
         aTCgPAIxjJxSGXy0J15lyGx2Etap0kr++nx686Cqis8GUKDla4OFXHp+MeGgX4i3StBQ
         ShXpqIRWW7MiEWPJzgUFrzMJYRw9RQOUjAuSmA/3B6PdowuMpk6Jklh7QXfSOQBqkp5J
         tJRI/XE/3PHzaG53tYM7hDpHiASeCAsVHl3DQlcGIxcgDWU3tDtZZPa7dpNjB+UBwA/0
         EP2A==
X-Forwarded-Encrypted: i=1; AJvYcCUhexMnsTq4Ru/uoReoOLOfOZCFLBg6qmAGwWWHxxOZZ6d5oKE74oqD8BNl7WACgUm4YoTHXHhf4f0VFkySY9tnTpp7OdBG
X-Gm-Message-State: AOJu0Yxw6DWjDcZCRmS2h6lWBqEYayH2/BhLyWWGBens04khqDtCfnvh
	N9A6J6kV0HiEmpkVacvwVMq1jvu4X0+HMxwM6mHwm3OUUwIGD2MtEBZajIy0cexNwLthwIjU7Qi
	o7tsCFWqkmamKSK0Awjosu5ww1prjYblS3l9GS7BmMtzifbASgF7Mrhfly3Z25L+yMHfEceJoe4
	vSTMlv/FwBsQw6J6xtSLeMXR8Y24jo
X-Received: by 2002:a05:6a20:9c8a:b0:1c3:b143:303b with SMTP id adf61e73a8af0-1c8eafa7573mr2348523637.54.1723613016863;
        Tue, 13 Aug 2024 22:23:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdZRuzr5BORXPw4xiTNxfSeMsERm+uEiuPU9gtfoN69wIp+0iSWNDVdKc6GMkTcU0cZjXWT0eGwLrjrBvb11U=
X-Received: by 2002:a05:6a20:9c8a:b0:1c3:b143:303b with SMTP id
 adf61e73a8af0-1c8eafa7573mr2348504637.54.1723613016313; Tue, 13 Aug 2024
 22:23:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806022224.71779-1-jasowang@redhat.com> <20240807095118-mutt-send-email-mst@kernel.org>
 <CACGkMEvht5_yswTOGisfOhrjLTc4m4NEMA-=ws_wpmOiMjKoGw@mail.gmail.com> <20240813074018.21afe523@kernel.org>
In-Reply-To: <20240813074018.21afe523@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 14 Aug 2024 13:23:25 +0800
Message-ID: <CACGkMEviUsiE1bj+RLfVzH7bmnL3s=Dg-uyC3WFcbNLGAPAbZA@mail.gmail.com>
Subject: Re: [PATCH net-next V6 0/4] virtio-net: synchronize op/admin state
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, edumazet@google.com, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, inux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 10:40=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 13 Aug 2024 11:43:43 +0800 Jason Wang wrote:
> > Hello netdev maintainers.
> >
> > Could we get this series merged?
>
> Repost it with the Fixes tag correctly included.

Ok, I've posted a new version.

Thanks

>


