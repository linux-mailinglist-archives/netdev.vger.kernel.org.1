Return-Path: <netdev+bounces-298053-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 32T6DAuGKmrkrgMAu9opvQ
	(envelope-from <netdev+bounces-298053-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:55:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA786709D0
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:55:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RTSNdxR6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298053-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298053-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 375CC300A488
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4D13C4562;
	Thu, 11 Jun 2026 09:55:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A15D376BE8
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:55:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781171719; cv=none; b=rd3jViR+RnsVFtbq3RGvcBJsYgQaHyTQAETxvJPO6yuDJpB8ppd1JxchTQhFvizjVi5pguK4YR0MuMUvupnK/9l73FPddCZnTbnDZ4pJaZgf1qmA28RQL+hqNnLCdaDqblMy1V3Z++I+zAqsGn6bYFIwm1mV5J+4Vo0rPwBxPE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781171719; c=relaxed/simple;
	bh=E9SO15uyyAfjDeXbLMmzKutv8CUXv7r2wvapvsQuH/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nmg7DRgZMLJ7TCe2NFuX0xUKE18XKAlieU3q9HFqPkT5CQ/2vlX5+efvlLkTABJ9r9msL4opHAHF/9YH/wDguFneQ7Yg40s/oMC1lZxuKKmvMQ1ieuhvlJEpUdzAmnpXJtw7E2uYNCupHp4zPrpSMYZLJUSS9KwTNvX5ImTJoj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTSNdxR6; arc=none smtp.client-ip=209.85.215.180
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c8573e75425so3086212a12.2
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 02:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781171718; x=1781776518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKIDXrzOU4smjqzdZP/hOemMYW/zVaqgrAinWNvJwIM=;
        b=RTSNdxR6v1m7Qe3Q0W4plMKn4lyvy3rZP0Rcex8AD0ERzDuXV4CIx5OWqAaNfj+T/1
         DoqCE0iYE80P5Q5kMX3DXhhbstZkaYNwu/DziPbxNi0CQeuoxvpLqnopbKMbu7nIPnek
         f0BKvdoCTyVGOxchAVhwkzPmoBls/8gIx5NpyBA7JwlBileMjbNUorcaCI7WwjxfagW7
         QtkC9VVZOQda8SxixZ0Laaw2XWboJy7lN517FaLxF5MKlmaCOrgndnNJnuEoEHui1oOu
         +ELhFUAhMUsDjH0qa1V6TRj2zJ98VHUonVAmrf4DuYsGqEzq4C0UrGJj+Ia0gehvhvO3
         zsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781171718; x=1781776518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LKIDXrzOU4smjqzdZP/hOemMYW/zVaqgrAinWNvJwIM=;
        b=PJgNCJeUBT33lhDweQVFhaCCDyY30XXOPHis/WIYiE9aYSXwJwypvl229DirJg9rR/
         a60BBNYwJW8u1Y5VmWQ9fS0TYFOzzOPJXH5KNe2Lfxl7ePqiQHjh5bixIQRXGTarJw7a
         WgUVIpx4Z548wL3R2YGuTyCiJxeoHYNh/DsQRZC7YBhw8wrbfJpnHQjxFILn1g7kgJtw
         IjNmmTdTnuhNOi2S9NduBp0tSskEQ6ckikkYKUCMbNv0MAsFhusw/hznekSi/q9gfgoM
         UsU9C3jL/RBWf83QjsIwRupv6Pc1IMBqhzCzMQQeCD6428h1XzpzwyYVuIrZMjQEJYVV
         VXmw==
X-Gm-Message-State: AOJu0YxnsjECP6TeHP+i4iwzKTM+KbLViDQ+QzTgxPMuxzkC02OqQRZ3
	mcaQWv952lqaQEygltF8y8BvRRqdrsf+DydJIbNtpZhGL+yP6+GTlGs=
X-Gm-Gg: Acq92OH/VMVT6ZTlhTtqEfPvehZr6lsBImuM2z6UgmexS63yEcZJcCALx6S9gNXIJTK
	RJ79PUkXKWwZZjaKu7LBkGskvG0vxRcKBkmZejL1o5VZt7y6KV/LXQA13UDrzN5S/a0P037VBRw
	5EymhfxTr5ZBeTnFMrM5v1gDwMp+VyiURPMePZOKe9NnIdWxIIoIiX9jvfypFjsfK9wNro4NTrk
	xfMG+rvkfdopU0uJ9Tn8rFoDjsQYtaelrFDhOHHKO1XAySSv7YkpiMNf0y3OHsa7ASlNynwJEM3
	X5rw92vHlBG/3havf+b3xDxuEFi14qUqKmIauOXe6+7zSnOIdJX26lUGCHVPnUp2m9CcrMUGSH+
	BHQkUv7C8NCZj7YejQY3v1wpR2BvEEmVeiWbuVhVXL42ASabrIX9XubU0HTXk0lBjk+nqA/0iQT
	JmFASUrULKaa8ztgKXYtAa4PxfnlNE63CJ/BXNTMqudFuLX1UwejQzy6aGCXmkNPtWtn5pDQoqc
	gYfRg==
X-Received: by 2002:a05:6300:2204:b0:39b:fbb2:5e46 with SMTP id adf61e73a8af0-3b5e342bc24mr2324793637.40.1781171717811;
        Thu, 11 Jun 2026 02:55:17 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8658827a74sm1095337a12.31.2026.06.11.02.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 02:55:17 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: sgarzare@redhat.com
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	pabeni@redhat.com,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	bobbyeshleman@gmail.com
Subject: Re: [PATCH net-next v2 1/2] vsock: fold sk_acceptq_added() into vsock_enqueue_accept()
Date: Thu, 11 Jun 2026 09:55:09 +0000
Message-ID: <20260611095509.19125-1-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <aiqCQCdPHw7Ja3tM@sgarzare-redhat>
References: <aiqCQCdPHw7Ja3tM@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298053-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,redhat.com,broadcom.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[rafdog35@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sgarzare@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:bobbyeshleman@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafdog35@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BCA786709D0

On Thu, Jun 11, 2026 at 09:42:12AM +0200, Stefano Garzarella wrote:
> Okay, but VMCI still need to call vsock_add_pending() and
> sk_acceptq_added() in vmci_transport_recv_listen(), no?

Yes correct, vsock_add_pending() and sk_acceptq_added() stay in
recv_listen(). vsock_pending_to_accept() only replaces the
vsock_remove_pending() + vsock_enqueue_accept() calls in
recv_connecting_server() once the handshake completes.

So the v3 series will be 4 patches:
  1/4: introduce vsock_pending_to_accept()
  2/4: fold sk_acceptq_added() into vsock_add_pending()
  3/4: fold sk_acceptq_added() into vsock_enqueue_accept() (virtio/hyperv)
  4/4: fold sk_acceptq_removed() into vsock_remove_pending()

Raf

