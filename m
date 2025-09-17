Return-Path: <netdev+bounces-224156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E130CB8150A
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 20:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2F34165DE8
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 18:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7A72FD7B8;
	Wed, 17 Sep 2025 18:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uDJhll4Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B57A225A3D
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 18:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758132811; cv=none; b=KYgj65qzGeanseYWxmBsOslFlozWOQfcu5qatRFNVfrXh7HngcEv5m3kM6MtBctE7VgfMZv8vvILePjH+/LTsqU+w+U+oS2xNEKKOos7Zwti3Vfh7MKusXgIkeBWF69rs5otrWdCSUMMdVd2y7a95Rr40WIjIwUlIV8QFT9+Y/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758132811; c=relaxed/simple;
	bh=sf6wNXBTrIke7AH8Wc5oL+cPWO6bmOfTC55926f4H/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AbY4Jtc17vAfln1O+pj0Iq56z9s4R3casPF3njujqstCOaZXI58BGDOJrE8KJf8pMYCpz8T5ikTYOCsID+FP4lOLYwyecyQUZYBi/k7Z/AtlTdVIFo7sKlvHQ2Hzu0/MEkoGLnoQQtYHFgZpNlpnbQUvZGs84jX2drtuSczTWgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uDJhll4Q; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24457f581aeso1084325ad.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 11:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758132809; x=1758737609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sf6wNXBTrIke7AH8Wc5oL+cPWO6bmOfTC55926f4H/M=;
        b=uDJhll4QpAMrjdcbwN9wd33g7Olf0qhvZ2yZRmPJRGssYt+mNjGU1sTeH4LnMEpCu4
         fjPCpr7a0RYPADrRpksZR8+CwP9NxW9sJV3cBNhcLipOEFR8O9nPLPKw7vNBti4gY5kr
         yUH3/nlGKbWyOz8MzJKfZzQq/zUSol6SM66JNhDLa9Gz4084lh1u0OqEwPJrDJ/f4mqY
         625JiTmC1q4QwH4rpfHjida0gVltZxy39bznngI0NUBEX4HDE5uAMk24f5LcXPqg8KNa
         IIgIfG0aoSRUNe1XbdoS/BIAHkF+qgkfYJZ26aMcaxSnCiwfo9m4sPWqmGt3arYmnjJU
         CrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758132809; x=1758737609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sf6wNXBTrIke7AH8Wc5oL+cPWO6bmOfTC55926f4H/M=;
        b=lTAazG0fs6kYnognHW+zggMXLNmSYsVTMR9NJbDT5Zy2UV4DEqk7yvieVhbantVzk9
         +BItpyz9MRpz3ZNOKHecNiGJ89k6hnDDaiRY6zodHJejUmbKYm7xxUDoKU1YV6FRxfzO
         1nTEj2wwNilP4ubna+yw2Xkyq/UhtKICnW4pp1AHK9QLnzYlROKh9RqUHHcqXeuovmKT
         FKBuS55ieelqC+f5wjOr8Og9x6Sait5m2dSByeVyscWsOUvbQgcCVPVAIKsUxrOqQn5X
         I++oh2WYnaeambBTn50tKfY1397r9U7xZXYEIwxURxto9BQczh0LEUzxuOxN7wJoaHHR
         zjFA==
X-Forwarded-Encrypted: i=1; AJvYcCWrcqc9WURz+7Ox4VrKBXQhel5HgSCS6Uz3Zr4FgKRlEj3ljG/2OV5slj22cNlFhxzsrgpSZ0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWHk/RvNKZccP+Aw9NQoqKlEW/4L7pid4mpTrG8uJuZUlPSF3f
	ARRq06lWAs2BMlIJseD03prsr0nCPxQN8d9YzeoqWizx3qKyHc6BQOKhCNdl6yBlWSTBfsWdLoL
	Ykk5/6dI5kfpM7SoGfPVVGQ0SB12Fr4x2NEbxh81e
X-Gm-Gg: ASbGncvtN8jPIWHR5vrxgwj8lo+/rxm67Xx2blI72RrjJeesMlaRt3pRn8cofoW4ZsO
	ZSV947BWE/Bvu3Xcwxaz7yu91MDZvFl9FBE3JTC7OylFy+hYWlsLonSuaWQLZsWbDnEAJlW/wWa
	UDLziV1hg8QBQAtcAW8ELcnKTqJc7YKB0cArvJygyB+NsNQ/jhpYdNC0YKIYwfqQIx3Im1ltiDB
	+852WL1zudpnKhw94Zg9XghOvjlwJndXSI2ZWz+zHW6JKWC0Ljrw9A=
X-Google-Smtp-Source: AGHT+IGCvnMZ7Z3FVQaQO9VWxrtGr9enHR87fb40XTvIQ5zsCsDS1/g0V4EqrVBPmqUDcL5SYgoQLUUd/3RPZpO/4W8=
X-Received: by 2002:a17:903:1986:b0:260:c48c:3fba with SMTP id
 d9443c01a7336-26813cfebfcmr38660325ad.47.1758132809417; Wed, 17 Sep 2025
 11:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160951.541279-1-edumazet@google.com> <20250916160951.541279-9-edumazet@google.com>
In-Reply-To: <20250916160951.541279-9-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 17 Sep 2025 11:13:18 -0700
X-Gm-Features: AS18NWDBpbufXOfO_PiiyDRjhpuGUWebBYVM2PwntbliJbKSVwDaU_yBaD1hjUU
Message-ID: <CAAVpQUDXvdg5ti6dUZz3bh+xPj9BBUGmWX402XUCUaJKtx7snA@mail.gmail.com>
Subject: Re: [PATCH net-next 08/10] udp: add udp_drops_inc() helper
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 9:10=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Generic sk_drops_inc() reads sk->sk_drop_counters.
> We know the precise location for UDP sockets.
>
> Move sk_drop_counters out of sock_read_rxtx
> so that sock_write_rxtx starts at a cache line boundary.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

