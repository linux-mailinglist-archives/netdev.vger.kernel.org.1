Return-Path: <netdev+bounces-260561-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHdSI1zAnWnzRgQAu9opvQ
	(envelope-from <netdev+bounces-260561-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:14:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB3E188DD9
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7096E31A0BB1
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 15:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC7B3A1CEC;
	Tue, 24 Feb 2026 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MX/IrIVq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="btAvDqr7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766E72264CA
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771945858; cv=none; b=ZBDjqlk4QTBetF79+w0QdSjBh4SNOQnCgnuSMP3LFs6022v5BqAgg67l6SGWxzxAoGkZaEqLdqFSbqjwMIIvSxet92M87hzhMQ4JBZLIHRB9DU9JZ13S4aByRrJMdbOXbrhgTNMcA4Ght1Md0KLmyXTXHcKomNvx80ggWeGOVmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771945858; c=relaxed/simple;
	bh=Yw++ySpwmZARZwDkHxFtsIMZXrLfykb7FK8NOCCtc9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0Hj/bHiE2smSeBXvC/nV2V0Q/XS/xoi0hyDlnRKLLtsZLuWDZd6hPHQMgJXwQp4ikpy4XfvlBawfvoAgN1m+2VJxMZ3p/BYOwZtkSpnqHzSoG1vCyqn364XOnVENk9e2LwZ6ouyvV6xltkRxx7ZD3zq39b6W2YPGT9EuCZO94Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MX/IrIVq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=btAvDqr7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771945856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CWBmRFKI0tFktXtE/HuJ4+L1Im2+ihdnnfM72IEIXjQ=;
	b=MX/IrIVqMkw86AOkR8JyYlL19npBfM4zm7yXdMs4NwkOblUvTcvDbNoEzlS2qImjydCluq
	oa42RfzJ5ZjJAQ7jkzqEaRjqGEk0R5YWGqL0UGWlwUwc6jLUydjDyDZtue+fh9iEKX03P1
	4S95+WykCQpY0liUWTIuYKPh0v43PJQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-M38gZtjGM2e3vR1m_zLIHQ-1; Tue, 24 Feb 2026 10:10:54 -0500
X-MC-Unique: M38gZtjGM2e3vR1m_zLIHQ-1
X-Mimecast-MFC-AGG-ID: M38gZtjGM2e3vR1m_zLIHQ_1771945853
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43591aacca2so5059048f8f.1
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 07:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771945853; x=1772550653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CWBmRFKI0tFktXtE/HuJ4+L1Im2+ihdnnfM72IEIXjQ=;
        b=btAvDqr7vvNnFS4194jqRw4VC3ROpgBO6TygWYlhe6ZG9pJOhGvuaAIxz6x/RIaFM4
         vfNUYADX7F4j+MDVdCRlXREZacwsIs5eeHNvPyRJtaoo/3h9U8pEFBU7rhjHsH2p/bDG
         1swDCn9xmuN5nk4W19vrnQLSnQK9mJweJXsQwmj2kgltLdR2zoBvRI/qGy25NabkkUcP
         GsCJWJz/GMgqtphXCbaFuJhoq1vKao9HOwXcuqCIoPTERYrlXArwZPgRAnlJfp9arWg6
         wWhMkLwalVmuhL3Q8MBjP2VpNLkx1mSR6LSqlkddtGLGKOzTqMvTlarl7YcgRUox6o8K
         h3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771945853; x=1772550653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWBmRFKI0tFktXtE/HuJ4+L1Im2+ihdnnfM72IEIXjQ=;
        b=R/hhzZuRr3eo5GPVzjZtGoppED6cu1rLJaF/RjekGpCNVcYoQmsBctw9sAwh/oYInj
         wDR3QqUP8i3RTaluLNSBjUN4jt+Cxreyy38TeMjE+JQWiBs2jdbwjRDvnIt325tVqoTQ
         rXJhoHVEe15dSz5Otpz6uLfPz/NvPRbkgaXd/1gE7evKK8EVfLoD2geH9CqprWYYwFw+
         aKfx2nMlDlyL8EJ9CSSr2TmXCVg9FMXr2TCc3NJaNyv5AbIV/hqUGRJMFoc2bJ4CwVG1
         N3qqcV6GBe4HcYJYr6Xi+OFx4cq/7WU+DelbSwD4GKheB25l9bA0n4xzvoDt1gLG2pzx
         MpMw==
X-Forwarded-Encrypted: i=1; AJvYcCWOusFm2Oy7+yT3Gx0fYcDt0ZrSFKNdLnTMZ8sctntfEkYkIkItgaYh/xNvL7ya5HXKWLazAzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5XMDEg0gGLsMW0biz9mju+U3yFlDgbt9XM6O/px85UDu7j79I
	BySL1yv8UNmqu11FnykZKAjrChsAAr4S3QYS+L8I+caBtN3ESwN726J8Ywy10VCkUdRIewab1Fy
	WOuH/7tqcRPfFpoPQbnFV9B9vbLBFGwKu3fM9MqigAoFWZ0Pfp6HxKw46oQ==
X-Gm-Gg: AZuq6aL9XWQtEjdeH7LCPSwcMxcCM2eeyLklSkpjX7YwkK1i+VjEBmbxa7k3t80On+Y
	t/NWbCSLTTB1KMZBV7f1QGwOjKiFW7Z8g8AugNf8Rs9ldlVqBpUs0fHi6XO9xPcpozeUMgtomwv
	42NjeSaVHphJgx3h/hs5a6ljhv1yzr3vsP6W4kpMyqCYFIKf2/b6yXcLzABtn6fdBSt5oIRgmpJ
	XJ0WApT1k/cJG7mchzjiJvjAg5Pw93pEXaWIS33DF2lKqHc16qOFV+I7keMe2AnkCmxzjwlTcC9
	/oEbTsiBZmNLtmE+ckce3kF/8eeLpe2OoaLKz8NhI/561c7h2T+pHVXAJCRou/OAxEAaumDSz4V
	ebAe6bG46xwP7nmYxFaPB5YkOxU7ixPJUAaJQmMWox0VoYRDIOwh1/UbkSpaJbkBf9epuVGE=
X-Received: by 2002:a05:600c:1e1d:b0:480:f27c:6335 with SMTP id 5b1f17b1804b1-483a9637a55mr225647025e9.25.1771945853012;
        Tue, 24 Feb 2026 07:10:53 -0800 (PST)
X-Received: by 2002:a05:600c:1e1d:b0:480:f27c:6335 with SMTP id 5b1f17b1804b1-483a9637a55mr225646485e9.25.1771945852482;
        Tue, 24 Feb 2026 07:10:52 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd68826asm9484475e9.0.2026.02.24.07.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 07:10:51 -0800 (PST)
Date: Tue, 24 Feb 2026 16:10:49 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	kuniyu@google.com, ncardwell@google.com
Subject: Re: [PATCH net v3 3/3] vsock: document write-once behavior of the
 child_ns_mode sysctl
Message-ID: <aZ2_cPL2zCYQznBI@sgarzare-redhat>
References: <20260223-vsock-ns-write-once-v3-0-c0cde6959923@meta.com>
 <20260223-vsock-ns-write-once-v3-3-c0cde6959923@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260223-vsock-ns-write-once-v3-3-c0cde6959923@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260561-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: EEB3E188DD9
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 02:38:34PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Update the vsock child_ns_mode documentation to include the new
>write-once semantics of setting child_ns_mode. The semantics are
>implemented in a preceding patch in this series.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v3:
>- update language to clarify language that first value is locked, but subsequent
>  writes succeed.
>---
> Documentation/admin-guide/sysctl/net.rst | 3 +++
> 1 file changed, 3 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
>index c10530624f1e..3b2ad61995d4 100644
>--- a/Documentation/admin-guide/sysctl/net.rst
>+++ b/Documentation/admin-guide/sysctl/net.rst
>@@ -594,6 +594,9 @@ Values:
> 	  their sockets will only be able to connect within their own
> 	  namespace.
>
>+The first write to ``child_ns_mode`` locks its value. Subsequent writes of the
>+same value succeed, but writing a different value returns ``-EBUSY``.
>+
> Changing ``child_ns_mode`` only affects namespaces created after the change;
> it does not modify the current namespace or any existing children.
>
>
>-- 
>2.47.3
>


