Return-Path: <netdev+bounces-165081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BBFA30560
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 09:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A613A7015
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 08:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F041EE7DF;
	Tue, 11 Feb 2025 08:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DbYM5IJW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49E81EE7A5
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 08:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739261626; cv=none; b=lvlX+6o9QWlZqgndmdCk9H7ebcCxDRxPd6mQAENynWva1zm/sSis6vBAiUSr1gwBh2QAUKnZ9HYmCJOa9PKIWoMEOnTcgOL5/CwFJXN+uHcV4cdzEQ8jvLMT6M8dVrB8ITiM1d2OmS9u+V8N/iN9ptCeERDopa7NwwbTCJQUu5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739261626; c=relaxed/simple;
	bh=0dvMrOU+jpUj7tdCPK1OdWeuBFlDOcoyCJs0wbTUm44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBYT9ktWQpoXqioKrf++CPO043U8hNbosEdbIsrbitNkw/zi51YL3HrxemQN+6+R2Hrya6/wXp7APYkzDJ+PpVEARXeBVdNVatXbDYNMzJdeZKLitppYqa6nppe0lt0V72tqZexqMgwQ8LAX1X6jD2gIsVJygiV1CccuZFqpE9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DbYM5IJW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739261623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1n8vkK3pIQpfbo4j0Rb3+1FkQLwn21MZFeg/srwCbfE=;
	b=DbYM5IJWEctXRUCDhqF7daBrdse4KcN5gk15oEMl+Z4lq6hBDz9bkNvtARHIjWHi8uXpz7
	OA3XossWiwzlHO7RSrU4JRjcDI3gTjsAWqSCGcXtJMW+4uZNe6h5Ax5VkP93cvKsxjFLy5
	IK8HyJNABgfRizR7d8iZ85XO3ePZCOk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-vz7MTIc2P6O-U3m13HZ-Ig-1; Tue, 11 Feb 2025 03:13:42 -0500
X-MC-Unique: vz7MTIc2P6O-U3m13HZ-Ig-1
X-Mimecast-MFC-AGG-ID: vz7MTIc2P6O-U3m13HZ-Ig
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38dc56ef418so1908328f8f.1
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 00:13:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739261620; x=1739866420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1n8vkK3pIQpfbo4j0Rb3+1FkQLwn21MZFeg/srwCbfE=;
        b=uvUpT8uwylZkySxl3D2q4SbrSpwOzzN/88CLP0syfRP1pmXQWyiTvafqJh8f96yqaN
         MWdhz6iqdEphCEBswe4QdYlte8edeWG46ap+P3mPGZedPJ1zVkh0+xp1+dN+/A23a+q3
         zzCklPWn0y9cjgcou2c2Vbiuasn+9k11LzAD5VSqeq1qvhBAaOKGBjz9q9Q/AEkVjLPx
         m56cp/YAALv3sumVeJ8Idtis7TeRM1IB+m/b6S+Pg/PXAh3/DgSFjSTJhMp84QSgWe/v
         Xnh2l5QtBN4Wq+XZ0sdAtIdyf1nLfaB9wa/VS9+3cwcIys2UVLO9fELpQ2NzNnmelX+d
         3TJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOoEvElpw0tlLCaPlncfOQP7+ZcNFt1yO+MgUV55v9HA+YwPDvXK4tsA++YOGvDA441zlDIBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFy8LO6N3RsOh1QZdAuarE3U2i8TxroChOBMyrr9SJoboJ9HDr
	BU+nlZjmRrbEadsmMFMpH8H6t+ELGkR4pIrFgkNuvyDxGdVoxYIUDCNCyahL+HIt/tmNYcyZ3Fk
	0284VtH8U6r7p1GXn7pNYPVKfzRCIsbuGak8J2La4RyFboZPz7lf6hA==
X-Gm-Gg: ASbGncuMlhscfr0hrS4cWpySVU6Er/Nf9ujn1E3/y4ViXW067FJk3eTFN6/01ohc8/m
	mz/ueFeP5Qva1lgcMKEPBr0moicoSIRATMrcDSXa2qAhjGrR5ViLbSDpK5My/GlLBHUQTPy6Ng4
	Pdvno0wspYtJMPOipKv4e72goSesAVyINIM78dIAxI1AHdbMDYz/rWy73W6C6wQwWBDWSjTe9ij
	JcRTHacscibTa6665LDnKaxjiEWgBmSoJ4qn9M7LMvrHycdGeK4QVmLRZxppHnnGRdJUPOXkeGm
	etKTUrOwKHFSm2DO2kDu6kqEXNNxc8PwpEDgLVwuBhXPnKDru0JCGQ==
X-Received: by 2002:a5d:64a6:0:b0:38d:dcf1:d191 with SMTP id ffacd0b85a97d-38ddcf1d528mr8272417f8f.21.1739261620710;
        Tue, 11 Feb 2025 00:13:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESlByLWTFDUB78pjxA1Dd6V3iLKw47Bgjaj5JruimINPkrnWdgcGJctJ+ryQRtChMGWsKZHA==
X-Received: by 2002:a5d:64a6:0:b0:38d:dcf1:d191 with SMTP id ffacd0b85a97d-38ddcf1d528mr8272350f8f.21.1739261620000;
        Tue, 11 Feb 2025 00:13:40 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd6080926sm8087046f8f.83.2025.02.11.00.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 00:13:39 -0800 (PST)
Date: Tue, 11 Feb 2025 09:13:36 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: syzbot <syzbot+71613b464c8ef17ab718@syzkaller.appspotmail.com>
Cc: bobby.eshleman@bytedance.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, leonardi@redhat.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, v4bel@theori.io, virtualization@lists.linux-foundation.org, 
	virtualization@lists.linux.dev
Subject: Re: [syzbot] [net?] [virt?] general protection fault in
 vsock_stream_has_data
Message-ID: <xx2igtwgro5ffbmdaahbwz6irolnfh4ktmdfatfrl72kppne7m@rp2ajscxfpp2>
References: <67867937.050a0220.216c54.007c.GAE@google.com>
 <67aaa81c.050a0220.3d72c.0059.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <67aaa81c.050a0220.3d72c.0059.GAE@google.com>

#syz fix: vsock/virtio: cancel close work in the destructor

On Mon, Feb 10, 2025 at 05:30:04PM -0800, syzbot wrote:
>syzbot suspects this issue was fixed by commit:
>
>commit df137da9d6d166e87e40980e36eb8e0bc90483ef
>Author: Stefano Garzarella <sgarzare@redhat.com>
>Date:   Fri Jan 10 08:35:09 2025 +0000
>
>    vsock/virtio: cancel close work in the destructor
>
>bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12bb31b0580000
>start commit:   25cc469d6d34 net: phy: micrel: use helper phy_disable_eee
>git tree:       net-next
>kernel config:  https://syzkaller.appspot.com/x/.config?x=d50f1d63eac02308
>dashboard link: https://syzkaller.appspot.com/bug?extid=71613b464c8ef17ab718
>syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125a3218580000
>C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147f11df980000
>
>If the result looks correct, please mark the issue as fixed by replying with:
>
>#syz fix: vsock/virtio: cancel close work in the destructor
>
>For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>


