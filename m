Return-Path: <netdev+bounces-251337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFF6D3BCE2
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 02:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 488CF302E72A
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 01:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D750B14B950;
	Tue, 20 Jan 2026 01:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="caylSLYJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tQzKPjYp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653E072634
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 01:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768872747; cv=pass; b=dv9ZN9CwnOPJvyMnKSDHHrpSh52XQ3tjkwlQY5PpFDnPjQxZAZbcIohC8NFY/WN+64XKz2XidKJyFsrg72KryF+hJl6k9aYxPr/RrOQOhUTK1eU1mmwZtzGqcWPqyRr1/d5qq4Tk1VA1/lbsVPG28K1II3Nnt0/eLucpqWnn4ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768872747; c=relaxed/simple;
	bh=HS+rs2sRhBDDAMedphcl8vavi4OEyMHPXceb2z5fJW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ug4Ae7Ea44d0orxWggAGiFml1BsZousJp7STs0NZQUXKXeGZIlnmUAer3iRyHAzWMu5OXnsPfiqzD9B35H923/Li0fNB3pugBnsHQAlxDUf5kZEjonT3e3nvjAxsxiZMhrCDcwv/VNU6cAKIvH+elJ6zY0YBqP3yb9JGQEEs+ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=caylSLYJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tQzKPjYp; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768872745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OsxU+JtWzgcHQNbkx+AZGIiB9jQi2bSbySQh+gDEg7c=;
	b=caylSLYJMjZOyQTUq+Ul+xC7s9qtseVsztSIRJOVAekSkZJ791Xb5FfUSjPHO+3A6bYbba
	c45kuJrjn5bgz7iUWY4HkKDuqqut8ETrPcYautfLXyf/z+MT4tKgUfO5SgpNmsIgdamE6T
	0/FLeOY+LsvuG1nqyIojsybT5oqxUhA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-31oX4cTkN3ygQCdLuxQfrQ-1; Mon, 19 Jan 2026 20:32:24 -0500
X-MC-Unique: 31oX4cTkN3ygQCdLuxQfrQ-1
X-Mimecast-MFC-AGG-ID: 31oX4cTkN3ygQCdLuxQfrQ_1768872743
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b876b03afc5so1110377166b.3
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 17:32:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768872743; cv=none;
        d=google.com; s=arc-20240605;
        b=E9j2hqoj3yRtXWiXPolD9UthqIMEEJr2a+zsEcxbY0gjxtzKLF0ud2evTwZYKeeizZ
         QK98a24hFw66MFh48ExGPle8Cc30nC3QUcmVgEdz3LWA70SJ6D4P5PEtB9FVnykyRo31
         4OdoQWFmmJJu5HmuelativHnIZetbF9pkKZw2kXMxGygm89c5zSWct3EeXQNLd15eH8X
         OXMGcgwXlnKncsu5EK3hiWsXIgNuTebGQTtTuC5YyBQXHAo4mxlqLChmAMKCR1rIuPmC
         8MM4Bn7Pt3mti4gRwN83FfBnFt/BhN/0USCgEEhYDgiSGnkxJZRJQH5ov3Dwg12kdlNa
         dlFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OsxU+JtWzgcHQNbkx+AZGIiB9jQi2bSbySQh+gDEg7c=;
        fh=1mDbn4DwVy20L78ki1SO9KtSLV4DlzeSN/4ALIDcUNM=;
        b=lckW33QPg2H2jPu4yU8HmzWEIcB/oin/0y5gGTqt162AJYm368KUIjLZHxWF2j7dyp
         gSSpIJNTC/5P3ktrbbxpowKHynb3oHjn9gad/bGhGxcwyZrExR96f+niXFRZqYNRsXov
         etMNrKiB8mWiJm28zJd23uj1bGZQGtxhs9zrGT0cIwZzq2r8xs9jtFji+gNFkK0vdJ/f
         I8tGkC7cXOKwK3CW2+sHB/9PDBtN0PpHPgg0GIba6zwOL9IwYCiT+8IMHCFVwz/ABwLc
         jmh7K1G5mMCBUEmqz8HWbYbC1JG8zHQAzvi6HzBB4QxqmL2IDokR5gpsT7xXo47m/fff
         VUIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768872743; x=1769477543; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OsxU+JtWzgcHQNbkx+AZGIiB9jQi2bSbySQh+gDEg7c=;
        b=tQzKPjYpsR9+36nkENpsNQmsZc82cmKfJ/z8Q1i6uKH2koSfnIBbtZ0YyZixt4Rpoq
         siS1UGiNMvwSjWNTxZ7ThTdNRDo3vZYfk66r4M11qKR6grhEheL086lGyMePMgLFG8Lk
         JAIUhMf/CbkHgWdwOTfSYkdNjDTdrx5UdIu2e7peP/C4nuvSEWh5J/dFs29UBN18IHv7
         qUWtHlyAspuf8rBUpfschLay7qJ73cIQCec8KGoalExRb/uhZEkwdz6JNsdrzliEBT7o
         hXLwfA6LsA4gUoIE0HFy/R/a7WGa9u8o0JZ9HkLnt8scfQ+S40Gh0TZSh18GDrKVIW8M
         Y4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768872743; x=1769477543;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsxU+JtWzgcHQNbkx+AZGIiB9jQi2bSbySQh+gDEg7c=;
        b=MffYImREvVLi2ecJVLktQ2F1/ATpjVtBBXVk6YpTdzsgRbUmrfmZgT5zmvLQm3d1n+
         aYX/5vjzEXKdZDRglloo2s8CD6e1Neul36G0WP0Uh3lruHFvHoZSOSXzW6IdG5fnZKi8
         6ACyM4vr4S2O2NN1XZO4rVesL5uB4KXtuE/qHRT3obWD7HT/nSHMz2U0icKTr5dAecL3
         1pVbLZNvIbz4zTaAK5CLY5qGMsmpb4Rt3HEp4vhgin1+He7if4O3SB+C10NHqDQMr2mY
         AHlJ1rGs/C+ZbtfG/S9jftXlUQ4GusGzAyE3i3DGZICblX1sdOHBr6clbczH7EL6zBmk
         bQrA==
X-Forwarded-Encrypted: i=1; AJvYcCVytruIhI1i+vOHF/qW3Bn2a9yU27f9IpYzJTRa6lcpKOTML1Q1tc0FDTdHGz29xw9uNKeYXYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZYT8h9WbXKsBSCg6LXgTJyXLMHemExvweRi85M4C2wmK3pCU3
	voFJuWfKMjvHnYEFEoFeeZIjP3be4xQT2sVt9ihM3R/Ndt+fJAgEZKfzCamP0GE271YjKtWlSPr
	X3enLduZKAqIymMhz6hneNGDrUHDQe6o4znJZJTBG/md7sG0pA+vqPFRNBiq447vO91MVGKwUDS
	f2ZsUxE+927pp1bpmbCskzv1TKkfzUQu1H
X-Gm-Gg: AY/fxX4isGrPA9+yGNkqp1HFdbCXGFmGJCuRBXL/jwYal3w2s8xPZv10PS5lXiZktVX
	XjydrENVkwJ/4sYXB2hL3v28J61YzCR9lX1jFBZgEap5xhhrRj/YcT7aJn4jSGZZxTLDwIBBq5v
	HSWBq9BU5OSsjVy5i+fBZxjbRn1Xztv7cpH0h8RZSmO1AEOZB3qKdWDPh1kMo1O7RNEM4=
X-Received: by 2002:a17:906:fe09:b0:b86:f558:ecad with SMTP id a640c23a62f3a-b8800236e57mr18223366b.7.1768872742773;
        Mon, 19 Jan 2026 17:32:22 -0800 (PST)
X-Received: by 2002:a17:906:fe09:b0:b86:f558:ecad with SMTP id
 a640c23a62f3a-b8800236e57mr18221166b.7.1768872742431; Mon, 19 Jan 2026
 17:32:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768800198.git.xudu@redhat.com> <58c5767a8a82352fb784d8d51ec844055b6d7ff2.1768800198.git.xudu@redhat.com>
 <20260119090916.1fe303a4@kernel.org>
In-Reply-To: <20260119090916.1fe303a4@kernel.org>
From: Xu Du <xudu@redhat.com>
Date: Tue, 20 Jan 2026 09:32:10 +0800
X-Gm-Features: AZwV_Qhnz65hOYE219XnOZAeK22v2xydMZgt7mHbCC49P7QqnmBYSPK55kXyaOU
Message-ID: <CAA92Kx=BFz4FnMRUQYYtWnBjwHEKExVuviA8bWMcfBi6=Tonww@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/7] selftest: tun: Refactor tun_delete to use tuntap_helpers
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

 Thanks for the guidance. I will work on resolving this issue.

-- 


Regards,

Xu


--

Xu Du

Quality Engineer, RHEL Network QE

Raycom, Beijing, China


