Return-Path: <netdev+bounces-204946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03276AFCA2A
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4E54243EA
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 12:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78C92DAFB4;
	Tue,  8 Jul 2025 12:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJCJhGu6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E924E2D9ED4
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 12:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751976966; cv=none; b=d8fFImIe5VdSVUl17lGgBN8xmtHfAsKwlWDz1ybHgikxanFm/yCgWcDlx3TM/CzeTI8i1Ni8OaPesY9OaHBYX6xMZ8WSwHVddubsGnPvAiiuiYMN+Ylid8nse7HEUrQWfkDJlvzSRJgt6k8Tu/AV+M+ZM/dfIHSa28K3NIQ89yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751976966; c=relaxed/simple;
	bh=mMvwMZD9hLg9tRND9y9AFG++SVAM192V2riYe9IuSMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MK2f3VbNrZS1pCjpPtD+90zJjOd33Fe07CQhQf9GGFKKzSRmBuHYGoCIagpvpeOEr5ha3b+P4dhchfwtEJ3TNhfL6mLmO7V+FsUmHAFBij5didPxYu5pIxoJ47BqZUNmyt4rEjP3Y9HepeshWbm/kOm4FrAL//Z6EuelGxJF/ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MJCJhGu6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751976963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XZQq54vH7L1wrrcZbYcmRkAtOhIXsJTAbiqEq5oFXQM=;
	b=MJCJhGu61XrCOZ1XZ6QdudkpYAdpQ0MTcubVe3cQFu2wRcocLDqTR8KJawcpRBS88Kvd0B
	mDwx7ZrPOWhE4JSs25cG6mvOdR/DYAO90IRG+gkM8p5AZTAPbAgow0f48yC6MpJt1S0j2f
	U6hgEBNvEuPkJ5maVS0Af6WRGxqBceY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-6uRZmGOmM_WD-3-ZEwI6Ew-1; Tue, 08 Jul 2025 08:16:02 -0400
X-MC-Unique: 6uRZmGOmM_WD-3-ZEwI6Ew-1
X-Mimecast-MFC-AGG-ID: 6uRZmGOmM_WD-3-ZEwI6Ew_1751976962
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7d413a10b4cso671935385a.1
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 05:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751976962; x=1752581762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZQq54vH7L1wrrcZbYcmRkAtOhIXsJTAbiqEq5oFXQM=;
        b=vr7KGTgKZUxEa0cVPMQGXeKYM53OTwvUwwkeCpYt8ivKa1aXyrKS+ruKcIptrKzBvm
         AfYt6gngBCWTLWZoj+IDWmv4co/LMRme8ReD+5d3bo4lfb5LYplt/vHC9E1ADaSMy5kj
         +y6a8wZ8qHSjL3gZ4/IIj25ICfxJVWdSsLfoX1wY83xpcSesJcjcemgKhwZDWbFgZVIg
         spk7+lT+4qJSZdZwbZ4Yj2OFd3/j5g3dbp6aJbuIMtrgfxEMuSfBoMxOeRWAZvGo4XcY
         /XjP63JkfruZZNA5KHbXoOwGJvqU7o4F/bjh2WiLZy7MK1lw+oGsRcV45EDuUWJnx9oB
         BTIA==
X-Gm-Message-State: AOJu0YxBaVOLuM9MCQEPt5hft7rH20irTDsLcVc7eK7fDbZ1BRY19Aca
	O2nk0PDQUhDTN5eYIna6aahMJXLitJAxfkyhkN8Qerx07MaNJIlyptTfBOcFqXohYWWKd94o9dn
	DbTEWielNt5tcAJBPq7C09OFWZYK9Upg4phi07l3afYDs1WAwTqD9lpLqXg==
X-Gm-Gg: ASbGncvwiphswquHFynAEj2R/VCpcLeXxiBNq4bsbw8lKAeH6ho3ELhluUBa+19/azl
	QFuokMI2/ZN7RdTPETaRoyoGySxcQY8D5MRHou1+bkw7yE2AoPFV1HCT1XtelpIn+cptJo9BLIE
	b8IxiIxzxNRIOktVDWjJpYQy+PxjPhsgGHv3rr9kOVOSL223cltoEVOk8E5sBgPVyZaUcGxNkYn
	jngJmIOMCcpMBJ4Alsuk7SngKhU7os8ndoOg6aPchLanyVdez9/zCjchENDwiWZ3cq4kZNiY6ku
	WzM7WcjxVdLuk78BjTa7JzgjuHQ=
X-Received: by 2002:a05:620a:1789:b0:7d4:5854:32ab with SMTP id af79cd13be357-7da034a52bfmr499248185a.36.1751976962009;
        Tue, 08 Jul 2025 05:16:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp808SkN2VjVP2MnyxHqj6j8BNYJYFMs1ro4neDCuuVkG+IqYJqwBjuFfETrwpfdtLPBIpUA==
X-Received: by 2002:a05:620a:1789:b0:7d4:5854:32ab with SMTP id af79cd13be357-7da034a52bfmr499245485a.36.1751976961632;
        Tue, 08 Jul 2025 05:16:01 -0700 (PDT)
Received: from leonardi-redhat ([176.206.17.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbdbb957sm769232885a.37.2025.07.08.05.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 05:16:01 -0700 (PDT)
Date: Tue, 8 Jul 2025 14:15:58 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vsock/test: fix test for null ptr deref when
 transport changes
Message-ID: <2bqmwv7oyo4zs2fszonhkt5vup5zhbuai4p6ylevkwktihm6au@kokjoj5dgnbb>
References: <20250708111701.129585-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250708111701.129585-1-sgarzare@redhat.com>

On Tue, Jul 08, 2025 at 01:17:01PM +0200, Stefano Garzarella wrote:
>From: Stefano Garzarella <sgarzare@redhat.com>
>
>In test_stream_transport_change_client(), the client sends CONTROL_CONTINUE
>on each iteration, even when connect() is unsuccessful. This causes a flood
>of control messages in the server that hangs around for more than 10
>seconds after the test finishes, triggering several timeouts and causing
>subsequent tests to fail. This was discovered in testing a newly proposed
>test that failed in this way on the client side:
>    ...
>    33 - SOCK_STREAM transport change null-ptr-deref...ok
>    34 - SOCK_STREAM ioctl(SIOCINQ) functionality...recv timed out
>
>The CONTROL_CONTINUE message is used only to tell to the server to call
>accept() to consume successful connections, so that subsequent connect()
>will not fail for finding the queue full.
>
>Send CONTROL_CONTINUE message only when the connect() has succeeded, or
>found the queue full. Note that the second connect() can also succeed if
>the first one was interrupted after sending the request.
>
>Fixes: 3a764d93385c ("vsock/test: Add test for null ptr deref when transport changes")
>Cc: leonardi@redhat.com
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> tools/testing/vsock/vsock_test.c | 21 ++++++++++++++++-----
> 1 file changed, 16 insertions(+), 5 deletions(-)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index be6ce764f694..630110ee31df 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1937,6 +1937,7 @@ static void test_stream_transport_change_client(const struct test_opts *opts)
> 			.svm_cid = opts->peer_cid,
> 			.svm_port = opts->peer_port,
> 		};
>+		bool send_control = false;
> 		int s;
>
> 		s = socket(AF_VSOCK, SOCK_STREAM, 0);
>@@ -1957,19 +1958,29 @@ static void test_stream_transport_change_client(const struct test_opts *opts)
> 			exit(EXIT_FAILURE);
> 		}
>
>+		/* Notify the server if the connect() is successful or the
>+		 * receiver connection queue is full, so it will do accept()
>+		 * to drain it.
>+		 */
>+		if (!ret || errno == ECONNRESET)
>+			send_control = true;
>+
> 		/* Set CID to 0 cause a transport change. */
> 		sa.svm_cid = 0;
>
>-		/* Ignore return value since it can fail or not.
>-		 * If the previous connect is interrupted while the
>-		 * connection request is already sent, the second
>+		/* There is a case where this will not fail:
>+		 * if the previous connect() is interrupted while the
>+		 * connection request is already sent, this second
> 		 * connect() will wait for the response.
> 		 */
>-		connect(s, (struct sockaddr *)&sa, sizeof(sa));
>+		ret = connect(s, (struct sockaddr *)&sa, sizeof(sa));
>+		if (!ret || errno == ECONNRESET)
>+			send_control = true;
>
> 		close(s);
>
>-		control_writeulong(CONTROL_CONTINUE);
>+		if (send_control)
>+			control_writeulong(CONTROL_CONTINUE);
>
> 	} while (current_nsec() < tout);
>
>-- 2.50.0
>

LGTM!
Thanks for the fix!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


