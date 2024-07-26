Return-Path: <netdev+bounces-113278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A363693D78B
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 19:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 594C3283C62
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 17:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B44617C7C9;
	Fri, 26 Jul 2024 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UAC4laxs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5058624B26
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722014627; cv=none; b=FQTSBKQ3NUgrQ0ohRR2wG/ElvUuxWYdQwATEc6nh77OAPsVckWr/ggFhneum5ZAGao60FFQdom5uZ+1FOMAOUNCdLkn0vLdzPPaKTwgZ33o0jAvKqh27Dm0PH2wOTaL/+hM/SOf3IsmNNNnxzrhXufOaV7TPPFqSBeZI2R3e48A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722014627; c=relaxed/simple;
	bh=yNoMRHgCaIt/EPnYiXLeowM8qa4hLJH246Wt3MYtiug=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sMlnGnomwsduaVLXja1/hjk8dTps5pIroGMyWfUUPtOuppZvfmclGTG2hZ6JTYmhKc4mpauPqL3TflNjpbx31s1+eCosDgpUbMBB63kzNbTIiHi8ltRaByWmEsVCP2BEwt6V5IcfH69vEyceXXmLv4JO/x8PBlchSlHaJMrQciw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UAC4laxs; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a167b9df7eso3198743a12.3
        for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 10:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1722014624; x=1722619424; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OxOBYHngxrM1ZbsYmdfqxhtP13mtEgZmWUe0F1gaX9Y=;
        b=UAC4laxsA0W4xacOVrsrhzz+FiAWjg476g/45PR+R8PV1vfPMRanfBM0kFzB3Qzx0p
         S2aLvodnnNmwNAG+lWNe6CQMyzGHCDmmFmdijVFsvJaX8lL/VT8Q55OfgNDI1T4Yee4M
         8METe9feoUv7hYFlqTrgHFbUm0FJwHxWs8zIyHmo6I2Hpb/XFhAPDyEOeNm1mE0QvLHp
         eqhv3DVmyED7xkrn30OF/3YjTp1RlsCMS6chp6y76uhxzDj4kOKTcqxQd1gjefPZbAS4
         gc/fx8eT4XnJ6nMMI8PlqceX3j0TxWEALq5k2aAd0k9mybz8ltdzd1s68USO1Mt1PkSY
         djhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722014624; x=1722619424;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxOBYHngxrM1ZbsYmdfqxhtP13mtEgZmWUe0F1gaX9Y=;
        b=FYgFsaovIuE9Vmp4ie+QuukAF97EtDXL44tUiu1B6H92wV8EYBmX6/eipuchKIKbIc
         MoggZO24GGYbguh8LtQMIrkpPBw5nsvYL1pwToy+lUF37n8xmwRRluB/YvrTd1zqbCxa
         Yx72MqLir+L+XMPuHF9AitVd9Tu/SBeBaPY97/duG+HAOyPlnkbsoK3+Fdw0g6cbtNoz
         CYYtgV1DidSXgmMddVpHh4IWeDKOspd55aEHrK+8zpRcrOCV+qR4j7C3iHe5yhYq1HS4
         xQjpeuaUGdB7r9Sc7BI6Fs7Gx1HxpA6RZe/QVluwrb9XbOcDVWGNoiBz+cepZj9j6bmf
         Sc/w==
X-Forwarded-Encrypted: i=1; AJvYcCU+EFdYI0FokUG08OR0bFpT0czeXmcvSRKs7Gt45LbrJnUj3rX/FnF+wOh/0/aSyF08eFwBp/j+V8cgE9o/Hl+WrmPDFidL
X-Gm-Message-State: AOJu0Yym+8yWt2I21+C4Es52OV+8bjcLobSh9ZnaB5nCYpqQV053/fdY
	uywRSMuYxo6B8Igz3X09MJWQmgr+ZKOsDKC5on+iXxyfP3lM8h2NkW6BqVCHkL8=
X-Google-Smtp-Source: AGHT+IFbWa9eIWzko0lQWbrKQtTdajN5NpJK99U98/lKkeBDPQm3oncCFUsQb9VEsp5efJYMM+tTMw==
X-Received: by 2002:a17:907:72c1:b0:a77:e2e3:3554 with SMTP id a640c23a62f3a-a7d40086febmr13280566b.28.1722014623618;
        Fri, 26 Jul 2024 10:23:43 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:4c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acac615c0sm199092066b.97.2024.07.26.10.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 10:23:43 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Martin KaFai
 Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  John Fastabend <john.fastabend@gmail.com>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  bpf@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf 1/6] selftest/bpf: Support more socket types in
 create_pair()
In-Reply-To: <20240724-sockmap-selftest-fixes-v1-1-46165d224712@rbox.co>
	(Michal Luczaj's message of "Wed, 24 Jul 2024 13:32:37 +0200")
References: <20240724-sockmap-selftest-fixes-v1-0-46165d224712@rbox.co>
	<20240724-sockmap-selftest-fixes-v1-1-46165d224712@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Fri, 26 Jul 2024 19:23:41 +0200
Message-ID: <87cyn0kqxu.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 24, 2024 at 01:32 PM +02, Michal Luczaj wrote:
> Extend the function to allow creating socket pairs of SOCK_STREAM,
> SOCK_DGRAM and SOCK_SEQPACKET.
>
> Adapt direct callers and leave further cleanups for the following patch.
>
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
>  .../selftests/bpf/prog_tests/sockmap_basic.c       |  19 +--
>  .../selftests/bpf/prog_tests/sockmap_helpers.h     | 138 ++++++++++++++-------
>  2 files changed, 96 insertions(+), 61 deletions(-)
>

[...]

> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
> index e880f97bc44d..77b73333f091 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h

[...]

> +static inline int create_pair(int family, int sotype, int *p0, int *p1)
> +{
> +	struct sockaddr_storage addr;
> +	socklen_t len = sizeof(addr);
> +	int s, c, p, err;
> +
> +	s = socket_loopback(family, sotype);
> +	if (s < 0)
> +		return s;
> +
> +	err = xgetsockname(s, sockaddr(&addr), &len);
> +	if (err)
> +		goto close_s;
> +
> +	c = xsocket(family, sotype, 0);
> +	if (c < 0) {
> +		err = c;
> +		goto close_s;
> +	}
> +
> +	err = connect(c, sockaddr(&addr), len);
> +	if (err) {
> +		if (errno != EINPROGRESS) {
> +			FAIL_ERRNO("connect");
> +			goto close_c;
> +		}
> +
> +		err = poll_connect(c, IO_TIMEOUT_SEC);
> +		if (err) {
> +			FAIL_ERRNO("poll_connect");
> +			goto close_c;
> +		}
> +	}
> +
> +	switch (sotype & SOCK_TYPE_MASK) {
> +	case SOCK_DGRAM:
> +		err = xgetsockname(c, sockaddr(&addr), &len);
> +		if (err)
> +			goto close_c;
> +
> +		err = xconnect(s, sockaddr(&addr), len);
> +		if (!err) {
> +			*p0 = s;
> +			*p1 = c;
> +			return err;
> +		}
> +		break;
> +	case SOCK_STREAM:
> +	case SOCK_SEQPACKET:
> +		p = xaccept_nonblock(s, NULL, NULL);
> +		if (p >= 0) {
> +			*p0 = p;
> +			*p1 = c;
> +			goto close_s;
> +		}
> +
> +		err = p;
> +		break;
> +	default:
> +		FAIL("Unsupported socket type %#x", sotype);
> +		err = -EOPNOTSUPP;
> +	}
> +
> +close_c:
> +	close(c);
> +close_s:
> +	close(s);
> +	return err;
> +}

I was going to suggest that a single return path for success is better
than two (diff below), but I see that this is what you ended up with
after patch 6.

So I think we can leave it as is.

---
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
index 77b73333f091..ed266c6c0117 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
@@ -408,28 +408,31 @@ static inline int create_pair(int family, int sotype, int *p0, int *p1)
                        goto close_c;

                err = xconnect(s, sockaddr(&addr), len);
-               if (!err) {
-                       *p0 = s;
-                       *p1 = c;
-                       return err;
-               }
+               if (err)
+                       goto close_c;
+
+               p = s;
                break;
        case SOCK_STREAM:
        case SOCK_SEQPACKET:
                p = xaccept_nonblock(s, NULL, NULL);
-               if (p >= 0) {
-                       *p0 = p;
-                       *p1 = c;
-                       goto close_s;
+               if (p < 0) {
+                       err = p;
+                       goto close_c;
                }

-               err = p;
+               xclose(s);
                break;
        default:
                FAIL("Unsupported socket type %#x", sotype);
                err = -EOPNOTSUPP;
+               goto close_c;
        }

+       *p0 = p;
+       *p1 = c;
+       return 0;
+
 close_c:
        close(c);
 close_s:

