Return-Path: <netdev+bounces-164630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 116BBA2E815
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90CC3A9741
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9B71C3C18;
	Mon, 10 Feb 2025 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9LlKHIC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34F91C5D58
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 09:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180622; cv=none; b=FG4berlk8pv+RebI9JO67Nz+fSTOlt/T1b9xW9sKo+UlgZYIug9YE1YH6jkKBEWMHEt4ExjK0IwL0h6UDOmHt5TslkqvD9AF16VHccv01V9n/9sE/wmUVMLlJ1ph2JnIV83QyXGbbvGinwT8Vzd14Egb+8vzOwa1cu3weg+z5Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180622; c=relaxed/simple;
	bh=4nnGRZWW2/AIdWnnKh8a2BrGef7FP9UITDSDs1NXlLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCD5/0J9qG/JN7IMbh6CJDctffbyMvLFnAsJorw26ramiLwPxo0RJA11ig7vUL/IsD207PqNFSHtgwSTtdy1YIJkpZJxAaIn4c9QdLyWwPmzILRYmKeTi1qdWOuBfLJb/FkLrXD9Yx3kMVc3mrEUfNo1CGnRA3vluK7KLrBZJ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f9LlKHIC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739180619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OV0I0aQqD+wSVhWeEAawFpUzdxgKYx0GC3wuNeeP0og=;
	b=f9LlKHICKjLt2lHUIpcTsx2743UOCrDx+IpYKKPb0PupL0RD8+NJIj29DcZjrWOxxrTCn1
	lImvy4jlxcDf8Sy8KofsMjbWd11dDZLK0WrLy61EFJiJTl7oPyfd3MvF3Z2NgLtXbsbIUi
	KGVNyIQ6WsIhp20eImPZLzRna5SdnjA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-M9yCyFfWOVSGmVSJUSsD2w-1; Mon, 10 Feb 2025 04:43:38 -0500
X-MC-Unique: M9yCyFfWOVSGmVSJUSsD2w-1
X-Mimecast-MFC-AGG-ID: M9yCyFfWOVSGmVSJUSsD2w
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38dd692b6d9so572886f8f.3
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 01:43:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739180617; x=1739785417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OV0I0aQqD+wSVhWeEAawFpUzdxgKYx0GC3wuNeeP0og=;
        b=Fcewhk8gUgd8CGinh1qBCzBbC1/nGsaqDBfrwoifwnqdzJNl1vGEwKuMIBAzcaplMO
         UCaExIvHitmmzejO73Fz3q73wjniYeb06kcCwy3VUzftADgPQD90pTDkMXzl+D0QSWId
         ZSrqEWpuE/PvHOonWaJdfK/SEBwogM1x63EvgqzAqjy3rkxJd0omFtxaykSLHWCMci7n
         7ufQLmwUIrz5b90bXbLyIXgjs5Ddh7nonMzM6SSI3tZGxUPFz2QEw6Er06XUBVLP4AWK
         +qGJ/e7qOHG4P1dLdrxYHwFt4nuqa8xgdT/30+NPizRg3AvRFWjFO6H8TvZrnq9zRoxY
         rTDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhGjGo021B6oZnY93WT//yAVWcqX/urpmRZ11NnkToI1UmDAMMIT00sqLgq5AeFjIkB+zMpCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHgM0g88wXnGJKB1KkZtPikgMp+8e72VFZTAg0TAeHt5lFVBR+
	+xNQPUeNb37/ENbPtHgjYJpFwX4Zs3oebzPq38vYGG4OKpB/hWpLh7ftzZfnjcseJMzBtn/tVIh
	+4vmOaGoqQ6uDNCzSCLOC8yeNIC1C8+PXpEs6/QzFzNaS8FxhrHOm/A==
X-Gm-Gg: ASbGncvMLKf0iPehDPARkjInL7jZXfMOawpTsQVX7zttDD785HQd6gnQDM2BYoIPTSv
	TY8uSGWcvYXjI1SLE7NGm+M55RisnG1QN48P+S2+oc9J9Bs03pFlvGce/ePy5+KJ7X1K5auC2nK
	E5uWepyFkHsxP+IHs4CO68s85CHYUsu8J4c+0DlYk1464GylgjM/TV8UN6ypKYCOxMSFwbZYHcE
	wBwHRZQYB3H4/654qyIwwaa3ZvWJxuN6dRFhIYZNtPOtRQfujjG/BCGcBqMAJSjr422buVOK8VI
	uo0L3qiU
X-Received: by 2002:a5d:47ca:0:b0:385:e8b0:df13 with SMTP id ffacd0b85a97d-38dc93338dfmr10260997f8f.40.1739180616983;
        Mon, 10 Feb 2025 01:43:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtDMMFpdiiXsWsysnFaQ7CSpb+NbM1wiCOHPvDVkxEiC0O13gU+wXlV45zGOW6comGIKK5/A==
X-Received: by 2002:a5d:47ca:0:b0:385:e8b0:df13 with SMTP id ffacd0b85a97d-38dc93338dfmr10260964f8f.40.1739180616626;
        Mon, 10 Feb 2025 01:43:36 -0800 (PST)
Received: from leonardi-redhat ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd8dee385sm4628048f8f.61.2025.02.10.01.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 01:43:36 -0800 (PST)
Date: Mon, 10 Feb 2025 10:43:34 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] vsock/test: Add test for SO_LINGER null ptr
 deref
Message-ID: <ysek3sr42wapewffu5cbtt5lvyso5u6xnq4u2nigywylle5dr2@xuzmkbsy3phh>
References: <20250206-vsock-linger-nullderef-v2-0-f8a1f19146f8@rbox.co>
 <20250206-vsock-linger-nullderef-v2-2-f8a1f19146f8@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250206-vsock-linger-nullderef-v2-2-f8a1f19146f8@rbox.co>

On Thu, Feb 06, 2025 at 12:06:48AM +0100, Michal Luczaj wrote:
>Explicitly close() a TCP_ESTABLISHED (connectible) socket with SO_LINGER
>enabled.
>
>As for now, test does not verify if close() actually lingers.
>On an unpatched machine, may trigger a null pointer dereference.
>
>Tested-by: Luigi Leonardi <leonardi@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/vsock_test.c | 41 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 41 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index dfff8b288265f96b602cb1bfa0e6dce02f114222..d0f6d253ac72d08a957cb81a3c38fcc72bec5a53 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1788,6 +1788,42 @@ static void test_stream_connect_retry_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+static void test_stream_linger_client(const struct test_opts *opts)
>+{
>+	struct linger optval = {
>+		.l_onoff = 1,
>+		.l_linger = 1
>+	};
>+	int fd;
>+
>+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (setsockopt(fd, SOL_SOCKET, SO_LINGER, &optval, sizeof(optval))) {
>+		perror("setsockopt(SO_LINGER)");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	close(fd);
>+}
>+
>+static void test_stream_linger_server(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	vsock_wait_remote_close(fd);
>+	close(fd);
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -1943,6 +1979,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_connect_retry_client,
> 		.run_server = test_stream_connect_retry_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM SO_LINGER null-ptr-deref",
>+		.run_client = test_stream_linger_client,
>+		.run_server = test_stream_linger_server,
>+	},
> 	{},
> };
>
>
>-- 
>2.48.1
>

Thanks!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


