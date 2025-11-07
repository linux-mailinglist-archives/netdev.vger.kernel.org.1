Return-Path: <netdev+bounces-236764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E04F6C3FB8C
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 12:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6349E34A011
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 11:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DA329AB05;
	Fri,  7 Nov 2025 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhwHFTIc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1EuFvw/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DBD31B81C
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762514613; cv=none; b=PdgvyXEAT6g0EKBGVHuSlt89x/rFQjvFXgPk2W9T2JT3o1FrC/tdlcVfqjCEJ0hTq6aePJHER5gMT16XlwgSui2nrUN7hCEgDpkkUwyOSnfHjyMNkMr1FkZ9yAsOv8885fnDZ/CBgTH/HSXokX6dfDpJT3ItiCzYAQFU/B/Tkws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762514613; c=relaxed/simple;
	bh=ju336C8V2rOmFyV2y2GPXsVx+P9bJlIsTi7qLQD21fI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CYhIw3q+PTJafFI0qEsSiiF+KiOf3mVE15xRQY0xbZjgKO2op2d/Jt5hSUwI2MxRNtmDr2vaRRA1DVLQcDhHsLKX41xBVBR7jVsZML5alrRY193+UR3xNYQu3bcW8m0HebWYGMOm0bTPyJ79rojy1V3jz1loe0qnZQ/d5anzxks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QhwHFTIc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D1EuFvw/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762514610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ju336C8V2rOmFyV2y2GPXsVx+P9bJlIsTi7qLQD21fI=;
	b=QhwHFTIcaLxHlNGXoRvtVJ4zfMXWggao/SUL1RwUF1NG63faL5R0pM+qXbHc9N6FifVtS2
	+e0S6YLlYFe4lFXKCtSsXh34td2juSwN4baVB1gc3EAWJi/xNWlcI+/aPbZoR+o2latiPT
	VjDERu45fGl6VLjr1moQaraqZfxh+qY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-lxncsY9RNkmcVI1z5Zjcnw-1; Fri, 07 Nov 2025 06:23:29 -0500
X-MC-Unique: lxncsY9RNkmcVI1z5Zjcnw-1
X-Mimecast-MFC-AGG-ID: lxncsY9RNkmcVI1z5Zjcnw_1762514608
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6407e61783fso659004a12.0
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 03:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762514608; x=1763119408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ju336C8V2rOmFyV2y2GPXsVx+P9bJlIsTi7qLQD21fI=;
        b=D1EuFvw/IEOtLL/SxBSWieq4BQ3k9HQHRCqaUdRLTIlWlYBzyv9/IZJofMlVBYSRrc
         OqIxQ1G5jpUXlstYm5R9H97upFMWe2RRtmCTzj9PCn55viwULr1HgOOJnliXxfOkeSSF
         BnRTpIminZTFpDa1qX6QPMd+JbDe7q7Vd5mxvSBSuhrG+0B+imrUAUAi+B0LUOGmm8CZ
         Xip7iEFtMpsIyFYW/OHnQQOgwFM6yyDTrY8YpZZSyb/gictFTXUy3Dbmb82QxbbLxqH6
         Ug6fgt0priae8u3XZQmUOXt8ijgyi6YA3pGRHc9BIpf6gFEahdw/RI/nq2OzynML3+U5
         efHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762514608; x=1763119408;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ju336C8V2rOmFyV2y2GPXsVx+P9bJlIsTi7qLQD21fI=;
        b=kMpNJs6XR9Nesks2Rb1KPjWqagfqjtNn5xjUFkePNKu8lJyE4xtC/2I2gmnihFy/ij
         OnpMqC/uXnQUCkhPgJqOhAb53jTQXS5SWSWmGZUPZWucy69qBEXB8tlN7cwhHdNNK1zx
         J84qv/sDK8DAFgmk7kLhLoEWC1ir5/uj9hWnsf8zqwZau7PBxKQPJk51jw4TAGGVqsYN
         X7Rr3i755e8tTCtIchU1qF0k567zFNNaVShEO60agxh//7w2yRAaGg/DCfL/yIfCXakZ
         kXNI2mEcfFw/05xPlFpnc0w0kM2XUs2aqYO71Zw8g5Ltgs+2F9rD9Qjx+7MX/Cn5GzGk
         5kdg==
X-Forwarded-Encrypted: i=1; AJvYcCWRK6HOrvwGUH3fU+7pC6lSgOqwn8dBoGkgN/VAg+Hc+U8ZvQuUCrWlu+r94KoOs+vfOEYNO2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuTWCMSyTocvf8HKc5D0KrEB+AhOAz7eFMm7emt8F+48bumrZM
	S0PSfQKVHwwc4B3CE+xocyghVVY2mhvve1zOFJS7xCuboEQY+ahpa351L2L18FQp+FAkXNAemr3
	1IrI4YFhd3W47I+KkvfnN7hYUKRAO5TyMR6CzCFPKplzkgkFqU++bvlQEug==
X-Gm-Gg: ASbGncs/v9oWs290Q7lVAY5vOsk2QT4v+gryQBexFhkrJFziaDWe1tvtHdhnjLGg5wf
	BOnmv/g4VRwOgWiwXXxzWX6xOsggFZ12h6CQrxm6DufD2HoxOjz7fD0Ym2oERoYYhb4tMABKHAw
	QkVVLw4k6ArpzR2SbjJ1C0wnGwJQKBGyBEzTjz7sLEt7CH78U3E0s04G0qCey0eihPZGGpslURy
	vpHz6RniAYYIiN7YHGdYQeQImjp4UQwjbvzDKxXz9FN7/YU98mM6bfN3CackbxC9fYB4zD5Qx0Q
	DrSM9+jrtUFzdl8hY9HHyilDOn6nvIqMkMOkh0evVpf/IJ20qXa+FPyhWzvWecBaW26jUVbwbbk
	TfyxzB1EaknV9vrjJe96U6f4=
X-Received: by 2002:a05:6402:2549:b0:640:ae02:d7ac with SMTP id 4fb4d7f45d1cf-6413ef01f19mr2578897a12.14.1762514608432;
        Fri, 07 Nov 2025 03:23:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcYHlACoRfLsu+4jLnbzqXeTR4ABl9ET25pmJvUskAXXOI75XtbZUjmqzdalYc7tgXbYiyDA==
X-Received: by 2002:a05:6402:2549:b0:640:ae02:d7ac with SMTP id 4fb4d7f45d1cf-6413ef01f19mr2578872a12.14.1762514608018;
        Fri, 07 Nov 2025 03:23:28 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f86ea13sm3933804a12.37.2025.11.07.03.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 03:23:27 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4B6A4328C1B; Fri, 07 Nov 2025 12:23:26 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 1/3] net: allow skb_release_head_state() to be
 called multiple times
In-Reply-To: <20251106202935.1776179-2-edumazet@google.com>
References: <20251106202935.1776179-1-edumazet@google.com>
 <20251106202935.1776179-2-edumazet@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 07 Nov 2025 12:23:26 +0100
Message-ID: <87ldkinl1t.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> Currently, only skb dst is cleared (thanks to skb_dst_drop())
>
> Make sure skb->destructor, conntrack and extensions are cleared.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


