Return-Path: <netdev+bounces-146834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67AA9D6228
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 17:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5A02816B3
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 16:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC931E1A17;
	Fri, 22 Nov 2024 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MctXfxfP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500D61E1A16
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292482; cv=none; b=Me//Jut3Jqr/n4ZHQ7cxnUg7egskBL498BL34Cnoo86OfVzEkOJDUryYeD9JrJP2kLMlVycOYoSLaUIWufw5RbggJVc2mE4mgB0Bvo8ZsUj9XIuLn55gghZPcaTjueaZ9AbiE/uCrbJoP/wBMOXrMyhNQN7w6Mv8a6xrNgfyQ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292482; c=relaxed/simple;
	bh=qKtTB5DV3Zl7Y+bAH9RuF3TD9YvDTYHWYvVeSislgT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BjqFGj38/7LFgbDYrmTa006r2DQx7d15cVYExcAjfAhbpEdArN1EyrXj95pBGupiugu9fg/tJlXmQmfP5x4Nv8KtJqcywLTkrA39hrBcqnp4QR7k1ahuZD96aHi70yzXdXnu4vmbR5hvPXkEuIbBbzbwcviM2V7xYo4pgT2qcEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MctXfxfP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732292479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qKtTB5DV3Zl7Y+bAH9RuF3TD9YvDTYHWYvVeSislgT4=;
	b=MctXfxfPobufAJTIZN1DFV1XrTqVYArGsgZysGxdZ22pctOnR8obDojkRN//qpmJlZm9ap
	oklp/UsRR4spujdGbQIfSYbRfAFC3mNfAPv9kQ7KjBFcEwC2MP/bbNJhoI1iUW1ATFhdy2
	Z/fifoAG6t2KxIn54yyLzjAz/AndwxQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-JVXWbiocPBW-U9FeSnZgrg-1; Fri, 22 Nov 2024 11:21:18 -0500
X-MC-Unique: JVXWbiocPBW-U9FeSnZgrg-1
X-Mimecast-MFC-AGG-ID: JVXWbiocPBW-U9FeSnZgrg
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-539e75025f9so1457882e87.3
        for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 08:21:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732292476; x=1732897276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKtTB5DV3Zl7Y+bAH9RuF3TD9YvDTYHWYvVeSislgT4=;
        b=PBDOI0XlwTitfQcJKEP0vsonoeB68Qp2EHxsmkMY1yXUgkJ+TWieGrl0HJ7lTcqLos
         uXS7pXMdBC4q303ghNxeCr3SaRoE2mwsaciKRY1neELrmtjquggOTvFxfWPjs0MD0Hsw
         v3H+cCDSPKey0v/w+9+oNOAsTDmpmR411pMJV5r4R/14iEZKm5r/ei8ZwxnDL1oz5BrV
         pKB0vy8FwQ41QHi/PIP5cw/jXVbZd0ubeQY8voa6u6J2Um2C1mUwaWPZteyK7RNp1c5d
         MiW92IqT9cAFZ/6IzuW9C8RX/iqGuuoq7vAI9rUd8d2FKL8Bbi3TgJDfa2hIQPbGf+r2
         6I3A==
X-Forwarded-Encrypted: i=1; AJvYcCUXQ9Vi5m1z6Hhm9V0NxsyYLqbq0ZTjuhik9t3aYWZRx0ujgPoRQaNnaBQnLlvOM9HJplIV4gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHm0M6RSW50cKIdSlRAEMF7nDIByPc7qMjC/8ITD9QaNrx05dx
	wNszaoQqFcbGiBIgUiXiYlVT4I/m1FhhtYgeyhG3Kwhc9DB91GL/RAqjKgpuF02Wqo+wv12OyF4
	7/plhdh6nh5k7XkyodroPvBtNoohate4jcJI0h+tGxWQZxsgwGx6CRg==
X-Gm-Gg: ASbGncuYoH+Rfizg+LyNvsUbeeqUfKD6sLbilnADRBvcC3PtXjqEEeCI33ZmwBt4SGO
	inCmRt8T1awXNAhysc8g/0RpMcnkYRF4q3Pw61r5i5FpX8C6FG7vvseZz/GZeN19k6DL7yigvXa
	Da3Cp6fn6aKOU0ie4G20wE/RORDRJTkFCA7jPByw1J8miWYj6IpfFdTx5VowsZMmmOmnh1RQ4EW
	YRE6rahUfMB6fMhtjvZXaN4YYQwCY4hWxla554rUpFWMIP8rLO6zBkSVTPVEQq61M4gh6U6WDin
	5IwScQ==
X-Received: by 2002:ac2:51c9:0:b0:53d:8c79:ace5 with SMTP id 2adb3069b0e04-53dd3aabeffmr2344608e87.54.1732292476506;
        Fri, 22 Nov 2024 08:21:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFR0ePfE3lovnWGuzpFCv2uMYuHyzHPO1LZjbHFLMvu00pbafujzeSDjCej37Sftl/YHlPHDg==
X-Received: by 2002:ac2:51c9:0:b0:53d:8c79:ace5 with SMTP id 2adb3069b0e04-53dd3aabeffmr2344568e87.54.1732292476130;
        Fri, 22 Nov 2024 08:21:16 -0800 (PST)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb ([176.206.22.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b463ab5fsm98768945e9.27.2024.11.22.08.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 08:21:15 -0800 (PST)
From: Luigi Leonardi <leonardi@redhat.com>
To: mhal@rbox.co
Cc: andrii@kernel.org,
	ast@kernel.org,
	bobby.eshleman@bytedance.com,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	eddyz87@gmail.com,
	edumazet@google.com,
	haoluo@google.com,
	horms@kernel.org,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	kuba@kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	mst@redhat.com,
	mykolal@fb.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sdf@fomichev.me,
	sgarzare@redhat.com,
	shuah@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev,
	Luigi Leonardi <leonardi@redhat.com>
Subject: Re: [PATCH bpf 3/4] bpf, vsock: Invoke proto::close on close()
Date: Fri, 22 Nov 2024 17:20:31 +0100
Message-ID: <20241122162031.55141-1-leonardi@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118-vsock-bpf-poll-close-v1-3-f1b9669cacdc@rbox.co>
References: <20241118-vsock-bpf-poll-close-v1-3-f1b9669cacdc@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I spent some time checking and nobody but __sock_create (net/socket.c)
and vsock_release can set sock->sk to NULL.

I also ran checkpatch, everything LGTM.
Thanks for the fix!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


