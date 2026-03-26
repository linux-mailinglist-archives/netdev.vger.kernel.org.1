Return-Path: <netdev+bounces-271795-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IH1gB/qWxGnn1AQAu9opvQ
	(envelope-from <netdev+bounces-271795-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:16:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F7C32E471
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 558FF3051AA2
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 02:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FED3382EC;
	Thu, 26 Mar 2026 02:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fgHe0u5S";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dgmdjjvQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D762ED141
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 02:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774490977; cv=pass; b=DERB/LnAcP6P32gb0aUo8uyI8U/utJl6QbKowLWTHUfOS3s/1EIDYKs6mTMZkm2jr9jzvo7Tmvr/pJo0dm9EKaKuKtWN0KyvrUfEZ0I1d473MIR1sdyLZDIatJvwKTB/jk6EgPBH8XysXXXwPFjt2uwUfTk0bXf8AusnTQtZV/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774490977; c=relaxed/simple;
	bh=SM+x8B+Pz15Gvc1EQP2Y8VvxinV8pQbKuNafLtpnPcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iM18bZuKNYMv4NNW/aV0K0TFMBtSe6pVgzE1IqgYQM2C9nnBcu0xgUrCEtN6pA8UzlLUHPoAU11Il94fQa4yKq6O1+3gzmqWTzbyetEusTe7PDLVvVeMFfCN1sy1wBuX1XaCJo9mYt55qf8nuLcOH3ZNKld+Wq/z7SICjkGHrPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fgHe0u5S; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dgmdjjvQ; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774490974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SM+x8B+Pz15Gvc1EQP2Y8VvxinV8pQbKuNafLtpnPcE=;
	b=fgHe0u5Sbt6tLlsSMUKUFdpKbv+szWcGulrdWbn1vzpuktuuojACvIuGF2LzsILyyaospw
	mJFEoLLsubmsbNpdNAbwzgQv8Zqvu3JuYdRfiDbhch378izbqG9QyU/Saf2zHmmE8jlg78
	3iS+VhIr1I9MaIBG1rWL7UQQuyqKyw0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-5uEJBp3-NfOvSs4QNTR_tg-1; Wed, 25 Mar 2026 22:09:31 -0400
X-MC-Unique: 5uEJBp3-NfOvSs4QNTR_tg-1
X-Mimecast-MFC-AGG-ID: 5uEJBp3-NfOvSs4QNTR_tg_1774490969
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2adef9d486bso8599805ad.2
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 19:09:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774490969; cv=none;
        d=google.com; s=arc-20240605;
        b=S4BAHRrynYXxwi4wKZp1i4korwyoDm9LJQM92+zIPE34PO1qkWMf2P9TpktOJ0jJQb
         03+dGOKzXEXtwcJAdYA9hvi5fps2DqqQ7GvvmhpG5rZWASHZzIw9lFOknWrkVt7w6WPM
         T1oYz7+5bJqQLXo7ztseEgm9wDhg2X4HArp/ftdX+icIkjj9OelOWBsvrivmkuPaTLkE
         mdMIezkr6rPr3VB1o3Sdow3I5CjSosiLPCwlTHp3WDINRlt61KSDI058BFZbuWNoWfU0
         S4saJv6UILC+/kRN4tbKBWV1e0xwzR9t2VZWeOWg1bVesHL8tYq8X5WAB8vK83J+H7CV
         22gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SM+x8B+Pz15Gvc1EQP2Y8VvxinV8pQbKuNafLtpnPcE=;
        fh=uH7QuIRDXouWtKTm5XBL+ZpNnS03TDoHzP/NwKsDMcs=;
        b=PpXHMOP1+/HNQ/GUaGc8FhdAeCQoPLuTFsp6DPHu6JjBXcRxmG19n8L9ZVsu8DfU8h
         YgGBiKLby7V809tuJ/JxEoq3+v4dEJWM//TDRy9tvFHOe19J0pq+sETx1pssBBWiqpnm
         I1MYCmdcKVeYifcPL+AMdK/CSBIhFtJ4j7ZjPLTOiM6SSKtK7Sk++ZIMF1JBeGE7dwpD
         hBvZlFjkOn5zqxZLJX9QlaQzIhc7tQGMCeDpJu6CqdZhFaWQPZBAxWBHD/FmUzejhJ8G
         bHYH0sBWcqD/IKOFijNE9j/Yu/Z87wtT86vt7siTQgEC4aQUYpmrR7qG6CltwVbHGe1I
         qWuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774490969; x=1775095769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SM+x8B+Pz15Gvc1EQP2Y8VvxinV8pQbKuNafLtpnPcE=;
        b=dgmdjjvQp7K+JooQx0xwwqgu1Ws+c1riVHbP90ERxHYNq3xGkT3BP3eIRV7uNMsxD6
         dqAWUXhgrE5LJ3XL7Imgm8BXD1r4nPZ6cxWVi/Xhb4YK5QY2iRWEGgQNGOG5TEWYA0rw
         84fGjY7n+U3XBujyQKrZj8OC9srsaVJdcy+ozWvHoAlXXOk1Q0M5u1XIfi983L1twujr
         i9J9OfQWNA8uFIX2TBDnRtr9ipb3DHL/SpVbLMfluKshuY+1TrhtIbuhve/cRdyay39y
         gGQCySXYdla/lYQB7lbjROw9AFcCcilnk4OmNBfiCLMOlHNeSNY+Nbace4fzH7Ls8V0w
         wM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774490969; x=1775095769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SM+x8B+Pz15Gvc1EQP2Y8VvxinV8pQbKuNafLtpnPcE=;
        b=V7GfrYYGlTaeqCkUE5STOtCDbOfYDMqofzu6dy26x7XigvmHzkziyRebpnEDaf5H80
         vTomhnp93Jq4ISoHaX/EBcPGY3zmAiDCPOFFl8Mkrfw/Ix11UfF+ooHWMQuB0YfS4NkJ
         2YShyrRkEQS1h4gktsl3NbifliF2G/CtZzhfW625VR2ahNHVso/UFCqRcMF8WZbFONWU
         6/NCmr4BUQj9Sp0a7c/Pgf2WSYxljXj6KhSvyLe9zn2OZ4x0lHn2BS9Pe1emxVi65FHC
         7LUgpgihhRUxOURpO2iUW2HAw2rCzoTfnmB9EWRhS0ZhCirYSAq1s6rJtG4UVaChuBVK
         wHpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEuqVVc+pnCw2CsQkMTMehX480WEJQypQuT9LpxkP7EoWlCzKUUFW1vxzI9tIr5C/+E2K2OJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEf6X7QbIDZz6MCCF7jXBqC0ISTdjaL529c5rJVD1lwIAewtJe
	k5TOnN391k+S6jtZH8nt6WnYW+g1u3krE9w9vavPiWufOu1Q2BBXWcQ0+nJnDS01+ssvOZYsUhJ
	z3JZcL8+Y+TGU4v4+dwcUdQZL0e/qOYkrSBG95zYIku8+PhjRCyMOQr7lVW/xdM2AdS0vHkJOk5
	BFTpd6L4tOz0oe8KbAGUsZgw8fvety2nLH
X-Gm-Gg: ATEYQzzPDx+WHnWFK1Az+HMqwktBbJWWboafYwbpP9CsMtXwqud1mxqkxetPhmYYvvI
	qUESyzKUxhh4jrw8wlNTaLj2ZhaR0O9tfjjeDpq1yRnFBRWjWJ1hGzTNsVJX8C9Edrf3B3muWSZ
	oJnj21AHl/Aa8BcEeWEt2c5PjtBtHRZkjpkC2wyLoxP67CXouDSfTRDoJbLewuAnEXyiSuIny8t
	gXA
X-Received: by 2002:a05:6a20:3d1c:b0:398:8546:c3fc with SMTP id adf61e73a8af0-39c4ab516d8mr6008494637.7.1774490969230;
        Wed, 25 Mar 2026 19:09:29 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d1c:b0:398:8546:c3fc with SMTP id
 adf61e73a8af0-39c4ab516d8mr6008444637.7.1774490968666; Wed, 25 Mar 2026
 19:09:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f4caa9be9e5addae7851c012cab0a733be7f0974.1774365273.git.mst@redhat.com>
In-Reply-To: <f4caa9be9e5addae7851c012cab0a733be7f0974.1774365273.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 26 Mar 2026 10:09:17 +0800
X-Gm-Features: AQROBzAQPVawV1gSLClGfkluwZR06MG28vS66UgSXN-aCJ_PcJcLGWhQhc3M-Xc
Message-ID: <CACGkMEt146_eZCuTt3qP02sjFXPMHb-1s_TcMnOBXox5k87Ugw@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: sync RX buffer before reading the header
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Omar Elghoul <oelghoul@linux.ibm.com>, 
	Srikanth Aithal <sraithal@amd.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Vishwanath Seshagiri <vishs@meta.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271795-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.ibm.com,amd.com,linux.alibaba.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,meta.com,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 86F7C32E471
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 11:16=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> receive_buf() reads the virtio header through buf before
> page_pool_dma_sync_for_cpu() runs in receive_small() or
> receive_mergeable(). The header buffer is thus unsynchronized at the
> point where flags and, for mergeable buffers, num_buffers are consumed.
>
> Omar Elghoul reported that on s390x Secure Execution this showed up as
> greatly reduced virtio-net performance together with "bad gso" and
> "bad csum" messages in dmesg. This is because with SE sync actually
> copies data, so the header is uninitialized.
>
> Move the sync into receive_buf() so the
> header is synchronized before any access through buf.
>
> Tool use: Cursor with GPT-5.4 drafted the initial code move from prompt:
> "in drivers/net/virtio_net.c, move page_pool_dma_sync_for_cpu on receive
> path to before memory is accessed through buf".
> The result and the commit log were reviewed and edited manually.
>
> Fixes: 168b61da6871 ("virtio_net: add page_pool support for buffer alloca=
tion")
> Reported-by: Omar Elghoul <oelghoul@linux.ibm.com>
> Tested-by: Srikanth Aithal <sraithal@amd.com>
> Tested-by: Omar Elghoul <oelghoul@linux.ibm.com>
> Link: https://lore.kernel.org/r/20260323150136.14452-1-oelghoul@linux.ibm=
.com
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


