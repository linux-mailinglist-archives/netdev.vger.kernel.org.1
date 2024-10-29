Return-Path: <netdev+bounces-140123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBBD9B54A2
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 22:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6094E284055
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261D220823B;
	Tue, 29 Oct 2024 21:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IetTBt70"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1AD207A27
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 21:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730235684; cv=none; b=IqoDUt789kysxI7geeV3V39QkOoKmsxlY8dV6sQ5gVe1V6A/SmxLa3MGgITrtYltmKzpw7bTik/vmUsjGY2PqOfsXBNnx5+lnBGYkf4Qo2TDyfxYv31w6lt0Y5NlNUk3eIkoz5Kl+wjrq2meMet+2SmVoSoRxmHkKV7IV7OuRHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730235684; c=relaxed/simple;
	bh=S1703cyT+edCIiD/vyQbgM7U8QSHOkGBkJY7OT0F0kk=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vCc2F23rcZxJtNlCh+pgRO1ajsbRcUpNUnlkuRxPYTPMw+ChaLgZOxlc/x+yS3XX7IOn71fTo+0uduVV6Mkc/oIMZLmdgJPa22Bx/WIzUlpVAXdS5/qu1JpJBlZtQe0dnCpYYxchxOrJlDk2X0dyzq8hoPb8fQUG0HZuDAH1UEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IetTBt70; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730235681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=43e2Evie9F4dANboMZ7JeIucTF4uD+J7mlJDUVVEjDg=;
	b=IetTBt70Th4rbil52AxajooDf73mdj8RHCnwTjZUI34ZwNtIFWELZL6srEwEq5m533E2cq
	IK2nvIeNbNwbZsBPDZxkrnG2nHGGWVW1nZM85UHhb2l22cvxjBT5Be6ReMpv+VWwjzh4uW
	SHobtO2WehiF9nwNNXWQW56b68Dc8Sw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-AiYSaQduMqyq-qWv1w6Bgw-1; Tue, 29 Oct 2024 17:01:14 -0400
X-MC-Unique: AiYSaQduMqyq-qWv1w6Bgw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a99fa9f0c25so399921766b.3
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 14:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730235672; x=1730840472;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=43e2Evie9F4dANboMZ7JeIucTF4uD+J7mlJDUVVEjDg=;
        b=ML7P5ApCh8CjULMMxu6cXTfi0AUaOlhcWvAAG0IDLCn+ytDnN3jFow76alp81HDXaJ
         ZxVzNXmRzH1vMamg4unz77ZGaOtoTY5G/U9pTdwm8GEUn2emIfvrTCm7oAxdByQw3/7I
         +LUpzMHywtvVhAofn81q32T4GAbcM7NGnv92vwUHj8FlzO01hxg/wqkwhm6uW+xkc3YD
         oXLKxTzyJfRHoXECwSVMc+ZWdMGcW6DJmSOYsbnhw8dPbdkM7hIZA9QdIvRqzfq1++r0
         1wS0EMSCGquwSWXcs9VJMIfrmwrZ/kgKTVdJgJw+WPsFTdwOg3R2xFfB7+y2TVS+NfqS
         JiHg==
X-Forwarded-Encrypted: i=1; AJvYcCUASC0dIOllehV1DVbMpn4r7yWVVo117D5rbq5RxskJi/5Aw9mk9tvsvUlLINonu75MwhyGALE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgJj8y6ImN06TY22tfn6swYCGLowHcKa3TffZ3X36jKXjhug2E
	JWWfD8v2LMKE3sEHtfA5ggmUrCVIeLjQp8kJzRLTh/V7H4EExfa0PiYcZU6HzDnKIaISJr3uBAo
	LGIWd8n4DFiJgGNC3jV8sgvA6NIb9H+SziS9arYOvDeoh+JKB+d6ikQ==
X-Received: by 2002:a17:907:1c29:b0:a99:e67a:d12d with SMTP id a640c23a62f3a-a9de61ce61bmr1233011866b.48.1730235672449;
        Tue, 29 Oct 2024 14:01:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1qigmT2ZHXS67eFLNcxyTAr/uVtukSkT86//Ve1k4KoNyQor1IgHemQv7UZizKSFDozLXDg==
X-Received: by 2002:a17:907:1c29:b0:a99:e67a:d12d with SMTP id a640c23a62f3a-a9de61ce61bmr1233008866b.48.1730235672019;
        Tue, 29 Oct 2024 14:01:12 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f297b04sm507491966b.134.2024.10.29.14.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 14:01:11 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1822C164B269; Tue, 29 Oct 2024 22:01:10 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: syzbot <syzbot+d121e098da06af416d23@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, davem@davemloft.net, edumazet@google.com,
 hawk@kernel.org, ilias.apalodimas@linaro.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org,
 pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] BUG: Bad page state in bpf_test_run_xdp_live
In-Reply-To: <671ecfe4.050a0220.2b8c0f.01ed.GAE@google.com>
References: <671ecfe4.050a0220.2b8c0f.01ed.GAE@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 29 Oct 2024 22:01:10 +0100
Message-ID: <8734ked3op.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

#syz test

--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -246,6 +246,7 @@ static void reset_ctx(struct xdp_page_head *head)
        head->ctx.data_meta = head->orig_ctx.data_meta;
        head->ctx.data_end = head->orig_ctx.data_end;
        xdp_update_frame_from_buff(&head->ctx, head->frame);
+       head->frame->mem = head->orig_ctx.rxq->mem;
 }
 
 static int xdp_recv_frames(struct xdp_frame **frames, int nframes,


