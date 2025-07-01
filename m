Return-Path: <netdev+bounces-202890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C06BAEF902
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20F9616E68C
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 12:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0DB2749C8;
	Tue,  1 Jul 2025 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQ7BIhnh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEA6274667
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751373747; cv=none; b=ual1pcn1oQiMKyvweviOFIPBhGz5j1iVjXCDFOBqo6FX08ppbSs8ifj1v3aQMNmfmuenDJUwAanP/4pSdeLsVBWc0i5llVRWBjVn7R7HjfG3PSBIip1FORainR1PnNPjRqe29HH5S4tTLkPzDYdN/aqwfId1ZtULdWyMmtK60m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751373747; c=relaxed/simple;
	bh=aibM3CEN4GlDaN5Q5oUKGzqAOrx2WCfZHlJS67dPa24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ism8ZU7nSl8BzXnUb8rE7Qfl9QogVUaQyc3vBwsw+MBbYnP8KR3Sm7VcOQOBn70LTYrOPHHEMvTvyv6/ygzQk/9UpMD4wni3F6ecpTTme34h/g775BdD10ifrl2VqAgYKfk1xlvKAGixVO6kPYLG8yvTFXunV4ezW8eBjG8GNJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iQ7BIhnh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751373745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5eb0wjmxKgoQIQfwLxvEHu9pE8U4ib0H+OzhXzeaAk0=;
	b=iQ7BIhnhg3V52nORuCY/hhO54i1Fph1Afz6Vo3WvnPgrcvam5tC1MzhP17OqqRjSw8hRUl
	jhxVbtNDxeJB2+qsmGFTXsXjSJ+UUXus23qcqg9UrRsoym2WjKAQQmC4q131gHpMeeiH4o
	oTx4sW+8VLaSCU2TTNGzMPgwfT9u1lU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-vbb9h-l-PuWDoGerc5RRRg-1; Tue, 01 Jul 2025 08:42:24 -0400
X-MC-Unique: vbb9h-l-PuWDoGerc5RRRg-1
X-Mimecast-MFC-AGG-ID: vbb9h-l-PuWDoGerc5RRRg_1751373743
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d40f335529so1022081385a.0
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 05:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751373743; x=1751978543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eb0wjmxKgoQIQfwLxvEHu9pE8U4ib0H+OzhXzeaAk0=;
        b=Qtp3LBzQUqj+gpnTgsaLUJroMNmXRE4FI4Sjsa8hhoP320AWVjofqPnuYJkEfhb09W
         YHjd7XFfjmj08XKGtgj76qwm/lXoaIYnygE/Sbms8xvN0r99HRMi/5mZXWIM1FkQPaSB
         IFjpMkKquh8PayrXs3igwwcypMXgxz+hxzfkIGsUOjgWzbG05ZrA4RTrGSEbor8weaax
         8Z8sLwS93SPV7+k640DkIsURWVetxkt+U3kYpwAO3bIX4y845n5JejYs+XDxpaeaU7R6
         u9ZDgMtNkDa5p75BJpjV+Cm93iE82ZKRWfNZvexmpZ5TlGR3CSnMqoMPSpdicgj0Pjqb
         oINQ==
X-Gm-Message-State: AOJu0YwhPTJ4NLTzbRSsMQKrzAF9bGCLMv2fuzdAPLPVurO3QntmwDHr
	z/3eSP2ZuS60OTMBZpdRG7MzCc5iU5dzvUbObaVqWCGSWwf4WB1Uk1vCBKO4lSfAohgDOO28q3b
	Pgb1WyXSNqmfJFlXRSEzAWs9FyVuWXb04bZ6FeLsAyLAWfWYq6CNBkV3GgQ==
X-Gm-Gg: ASbGncueIROLG9RbIeUSVPM9LxRtTFlpKjWQVbvowZgEkVJNw+fMp6bWxBaDWAO2+Jf
	C9HiLlbzqQtQGO+GHEMpTP4efZb8Z8aB9oO5K5O0H53+XrvY0Ky35Qzy0NhdJBRH6Y+ZvopNFZ+
	Ite26n90U+RekSrs+PkD41usTNF/L4IiBx/nRb/ZTJvBWrtRH41hb/BI6wpLVjZHbWTGqZdNH7u
	Gk5zEhk2RBaRo39ChcYmNIN42RRn/NMiT8hNDMuoMMzc4zCiUel8/zZ/u82ebUz1I+9xbz4f9fR
	1ugB0jc1b+n6yRS8/9Ylu+P919vM
X-Received: by 2002:a05:620a:2b8a:b0:7d4:61a4:dea with SMTP id af79cd13be357-7d466d304bfmr486922985a.7.1751373743366;
        Tue, 01 Jul 2025 05:42:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvA9cqKiGyYmMspm7UQcXD+JNKsXtSkygKVN8QiyRw0x71aIOnzq9VTSOJAu5f4SJwOywqbA==
X-Received: by 2002:a05:620a:2b8a:b0:7d4:61a4:dea with SMTP id af79cd13be357-7d466d304bfmr486915985a.7.1751373742656;
        Tue, 01 Jul 2025 05:42:22 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.144.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44313689fsm766012285a.16.2025.07.01.05.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 05:42:22 -0700 (PDT)
Date: Tue, 1 Jul 2025 14:42:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	HarshaVardhana S A <harshavardhana.sa@broadcom.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	stable <stable@kernel.org>
Subject: Re: [PATCH net] vsock/vmci: Clear the vmci transport packet properly
 when initializing it
Message-ID: <37t6cnaqt2g7dyl6lauf7tccm5yzpv3dvxbngv7f7omiah35rr@nl35itdnhuda>
References: <20250701122254.2397440-1-gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250701122254.2397440-1-gregkh@linuxfoundation.org>

On Tue, Jul 01, 2025 at 02:22:54PM +0200, Greg Kroah-Hartman wrote:
>From: HarshaVardhana S A <harshavardhana.sa@broadcom.com>
>
>In vmci_transport_packet_init memset the vmci_transport_packet before
>populating the fields to avoid any uninitialised data being left in the
>structure.

Usually I would suggest inserting a Fixes tag, but if you didn't put it, 
there's probably a reason :-)

If we are going to add it, I think it should be:

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")

>
>Cc: Bryan Tan <bryan-bt.tan@broadcom.com>
>Cc: Vishnu Dasa <vishnu.dasa@broadcom.com>
>Cc: Broadcom internal kernel review list
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Cc: "David S. Miller" <davem@davemloft.net>
>Cc: Eric Dumazet <edumazet@google.com>
>Cc: Jakub Kicinski <kuba@kernel.org>
>Cc: Paolo Abeni <pabeni@redhat.com>
>Cc: Simon Horman <horms@kernel.org>
>Cc: virtualization@lists.linux.dev
>Cc: netdev@vger.kernel.org
>Cc: stable <stable@kernel.org>
>Signed-off-by: HarshaVardhana S A <harshavardhana.sa@broadcom.com>
>Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>---
>Tweaked from original version by rewording the text and adding a blank
>line and correctly sending it to the proper people for inclusion in net.
>
> net/vmw_vsock/vmci_transport.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>index b370070194fa..7eccd6708d66 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -119,6 +119,8 @@ vmci_transport_packet_init(struct vmci_transport_packet *pkt,
> 			   u16 proto,
> 			   struct vmci_handle handle)
> {
>+	memset(pkt, 0, sizeof(*pkt));
>+
> 	/* We register the stream control handler as an any cid handle so we
> 	 * must always send from a source address of VMADDR_CID_ANY
> 	 */
>@@ -131,8 +133,6 @@ vmci_transport_packet_init(struct vmci_transport_packet *pkt,
> 	pkt->type = type;
> 	pkt->src_port = src->svm_port;
> 	pkt->dst_port = dst->svm_port;
>-	memset(&pkt->proto, 0, sizeof(pkt->proto));
>-	memset(&pkt->_reserved2, 0, sizeof(pkt->_reserved2));

Should we also remove some `case`s in the following switch?
I mean something like this:

diff --git a/net/vmw_vsock/vmci_transport.c 
b/net/vmw_vsock/vmci_transport.c
index b370070194fa..d821ddcc62d8 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -135,10 +135,6 @@ vmci_transport_packet_init(struct vmci_transport_packet *pkt,
         memset(&pkt->_reserved2, 0, sizeof(pkt->_reserved2));

         switch (pkt->type) {
-       case VMCI_TRANSPORT_PACKET_TYPE_INVALID:
-               pkt->u.size = 0;
-               break;
-
         case VMCI_TRANSPORT_PACKET_TYPE_REQUEST:
         case VMCI_TRANSPORT_PACKET_TYPE_NEGOTIATE:
                 pkt->u.size = size;
@@ -149,12 +145,6 @@ vmci_transport_packet_init(struct vmci_transport_packet *pkt,
                 pkt->u.handle = handle;
                 break;

-       case VMCI_TRANSPORT_PACKET_TYPE_WROTE:
-       case VMCI_TRANSPORT_PACKET_TYPE_READ:
-       case VMCI_TRANSPORT_PACKET_TYPE_RST:
-               pkt->u.size = 0;
-               break;
-
         case VMCI_TRANSPORT_PACKET_TYPE_SHUTDOWN:
                 pkt->u.mode = mode;
                 break;

Thanks,
Stefano

>
> 	switch (pkt->type) {
> 	case VMCI_TRANSPORT_PACKET_TYPE_INVALID:
>-- 
>2.50.0
>


