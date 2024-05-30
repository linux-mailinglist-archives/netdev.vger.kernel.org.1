Return-Path: <netdev+bounces-99269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C406C8D440B
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 05:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A931C21546
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 03:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791EC51C4A;
	Thu, 30 May 2024 03:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IE2jKDm0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A61482ED
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 03:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717039480; cv=none; b=cqLJoj9B1hXxWjHcCv4AsE+RfqO69Sv2A3Peb8ygcFDrVDjJ4Y3P2mGOJrcajR1INcqK2PJLTVtXj/3eU1raxYTjm/jGnQdWsNSsGyH8WnsYxMVh80siBguWENpTgzUfmKumCxLweXnzKJfaH92AitmT6OIx+F9bY+/yNQ+kSHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717039480; c=relaxed/simple;
	bh=a+8/wSWGurAyL1xP57PH/iWopIzIysBpD7hmI2WgIbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CnCX2QfPVCQhW/B+FAKer6e/40WZEB5jFpCJkz8JOPrIAdM9jicaSdxlmDUvhNQreJlHNtP47A64xQc5MAma0AvQ7bPVkX9eLzfqVnZfrDUkOcwT6Qvq5ZT6O1rS8g9nesuL0OLc+bwzkTz9tL7aeP7QVmqN6+aOXPaYl40Jhf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IE2jKDm0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717039478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+8/wSWGurAyL1xP57PH/iWopIzIysBpD7hmI2WgIbw=;
	b=IE2jKDm0bTYZzfm7rdDyeS/9Ld0DzLGee7aiyd++w5/zVrIJ5l/WwzJtl14ydD2ajo3x7v
	9uceTCGB+LEgsSsP9MWEt24o6ZxqM3eG0cneMWW+ZuRZAO1sbotQGuknHV/zYt5tiftEpl
	cZ4+MfqeqRJqAixkBlnXALwaU4PtpKs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-6AbJa06bNnuo0jODyo7-AA-1; Wed, 29 May 2024 23:24:36 -0400
X-MC-Unique: 6AbJa06bNnuo0jODyo7-AA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c1afd956a6so68175a91.1
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 20:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717039475; x=1717644275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+8/wSWGurAyL1xP57PH/iWopIzIysBpD7hmI2WgIbw=;
        b=sC1YpWemAUWzKBZDj9k4ZpPaY6XKdUibaYPH2A0XCawEQZSItt/rrFCyKiHfJtHLOU
         oAMbH7gbCR8TyVYnWVDqa1q98xeWPaLpAeSX0PlNk73fnHT3FBGOFCSea+Cbthh6uurQ
         Oi2Fk6Wtu/z461eCjzUsDYB0mNu65DPxzG73wHmFoqeyIljExEHhwxZYH6ThBKIDNDRH
         kta88IaE00+sj7wTRgAUrEcpteZzAO+1JIejBDo3c1btoJR28BXJYrsCSkHM9S0+41ud
         ySBu2DaGn/eAcjfWgAR7qPX7yiDLaoKnhfHoWPdNQ5P8IKKQxzX6tvSWRySEMveAWAx6
         masA==
X-Gm-Message-State: AOJu0YwsU+3lpKf15IyEjeZuCWYi6zCBbLLufdTjUpKLI9LalrH6b3Tm
	SNuPPiEYiqmvVkHjxBIFdj6wAyO0g8t3sl+ZDmQhW+Gq+RscqJgzhoTFJQK3fSthGDEcxrfEtNs
	uykUEsWJTr3t706NugLsth9P+AVnnZ3oAcjAEUn84yJ5jRuk6XafdEQAFaKnRVe6PD5nx1nFO9C
	tjGLKatwxQkEdaWKbWgPR3o9FMoJDd
X-Received: by 2002:a17:90a:398a:b0:2af:a2a:ad67 with SMTP id 98e67ed59e1d1-2c1abc12489mr1001952a91.4.1717039475231;
        Wed, 29 May 2024 20:24:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnGrS/Tpu0K+sc6kW8BJyvn+oBs4u8ZwjRYuo5hvIzg+1YBpSRBjPcptyuj5g5pFuW4H/euGjPq4Ov1Fodj2I=
X-Received: by 2002:a17:90a:398a:b0:2af:a2a:ad67 with SMTP id
 98e67ed59e1d1-2c1abc12489mr1001935a91.4.1717039474765; Wed, 29 May 2024
 20:24:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508080514.99458-1-xuanzhuo@linux.alibaba.com> <20240508080514.99458-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240508080514.99458-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 May 2024 11:24:23 +0800
Message-ID: <CACGkMEte0SF-Mo=y5knNODpAtB0jra3rst3rR1kGNPZLY23hjw@mail.gmail.com>
Subject: Re: [PATCH net-next 6/7] virtio_net: separate receive_mergeable
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 4:05=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> This commit separates the function receive_mergeable(),
> put the logic of appending frag to the skb as an independent function.
> The subsequent commit will reuse it.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


