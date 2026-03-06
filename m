Return-Path: <netdev+bounces-264675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMu1CYVmqmlOQwEAu9opvQ
	(envelope-from <netdev+bounces-264675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 06:30:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EF521BB83
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 06:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 770BA303353F
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 05:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B683B2641C6;
	Fri,  6 Mar 2026 05:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n7rY+qlj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D049F4F1
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 05:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772775041; cv=pass; b=BmoITMx7nkQlyMZ61rhaG9oixDaIJAqaSxsuWrDpaSFKTxMr87LYt+izu8gNtNH8q9UPmhGPIfj8baC+1wcEqiGqT80TkWf1NmWbpz7J3ZuLVR4z5Fi4F7Sb07uN1Ig7Z84XnSk3FPsYCsPRiUuct/ZUeeZEIyhuson5PFl4yf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772775041; c=relaxed/simple;
	bh=AWGhhnxNa8/lqkUCLrnUcXuM6cvCw6BkFJLMfMuM34I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJ8LdI2M8W0hO/JV5sxZ60Tc9luz28D2iODf7O4qZneVhxsaxxpCTjS5a7qeHt0Qxw8YwcFAHispNbEJNmoWRCAzAPOrGfeIL2B354hibadPzD9S5pdA34u43yOBqRJs1dwyFwLLT6t7SRu476IDzLzMCPl4JhyZ2T80MxwWUrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n7rY+qlj; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1277d379936so10440694c88.1
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 21:30:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772775040; cv=none;
        d=google.com; s=arc-20240605;
        b=Vk1uxLRafVKCsFSVyagmxk2IPXYUkSxz8crmti0t7t4KPmeBYGo8hdur8DsbZ0t6OZ
         IVxzwpcXDXd1y0/AtLX+YU5HlAgHkCD8AfRstY34837GMiQcTbfB1pXIyjtkgCzqy3EL
         J5cH20G/1oD6Fc67DCR6zqSTKt1PSM36dZkEifC2rGUKilcMnYOzM0+alCnkubtjCqDP
         pEWgcGIAbFndMzAh8vKMZ1n5OLSKasTZamo2GXsaX16XI/GwxE8QP5G7ZLjgG7oF3Tkf
         ONa4yl5/u+Zb0dBJMp5Shwi3Bsaf0iwWQ/BSsK0dcjsytPw3DAAb+Irtr8BPli+tFkSj
         5tiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AWGhhnxNa8/lqkUCLrnUcXuM6cvCw6BkFJLMfMuM34I=;
        fh=Cf5bWJGUz777me1MqYMWsLb7v7Eq0uN3qhknnQOb9Yc=;
        b=j7cbTzkkA3fr0BXdntVPlbRenfMHQmllxtgO5gzXlxDSHBDmne6WMUBTYTseS0AuD2
         x1vLF1Xez7fB1kv6mUl/TXPBeTZZEkhcUVJn5sdcryaD3ia47WAjnwLyNIsjILIOw2/7
         9Y2FIRs/Bfpjdc6Npa5yOu1EzAMJnyAFWmtR6txJrMsIrUBMogdRDGOYKUEPDDD00siJ
         7sLFyt9tTWt8d2UxcZWdly+70GqcsXEM+Ki1XLIpraCO4yRE5H7MlsCsCElkyYnLcgpl
         SeHoA4sWYlPa0P5FckGxEnBJM4zbqRDcdyJEad/QZ9DRdMvNfmUH4Cqby5aXsWfBXqlW
         hBmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772775040; x=1773379840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWGhhnxNa8/lqkUCLrnUcXuM6cvCw6BkFJLMfMuM34I=;
        b=n7rY+qljZu+gNr/jg8/Xf2rAwcD38K7KWMkjDOY+RyPTxUKzGTHBhKiw11Xdv31VOq
         de9fBXhEYmuVnQsPfzfit3y+2Ao239L1mpxl3Pyzfa5sQY+E0HrwawSUQJSLyz43ZzTA
         PhafU+MBwH7mQZRjUY9KUuzxx1r49YnP1p+qNz86ABaW/kV8YFAtaRyQOgLE1FLvbDOS
         uqb2DZtK+G7qre7uB2XWIV66VPYOop490DRPlL12n62dVDSZqPlfQht3hizjVB5rBTj2
         j7+brbfpqyTGMwUN8BiGRuXfetXTnrb2rX1Gjrpk/ztHA09+r1WkN7LYVUEgzILyTnLk
         ZrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772775040; x=1773379840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AWGhhnxNa8/lqkUCLrnUcXuM6cvCw6BkFJLMfMuM34I=;
        b=uHZC5AnkHWGZOnyBymtirccrL2BLoD7CQ0h+Nfs4ZHOXJn6mpvNgofbXFxEIW+4W4O
         QVNh4geWZapXiq99LbFfsAP4b8g90pbtTP6jkh8Icfr0kIdeIUmJK0hHUpJkMxC2Zxdn
         nqfuf8/VL2CZn05X+dKT0sksRiejtN8OK5SQJVuwpHdZzcE/pHd+rmLWmXbtKm2H6ujr
         e5EgpR9ibhUuXGOr5AU0qjqPIokm8AtdtV/RYY0hxzYc5v79MRCqfChGmiw//IYB9jva
         9/c9j4mrjueITE0yzst3jQqKR1wUscqOimh5VTEr6DaVolFY5e7tNfaQJZYMrD0HNmT3
         ZWLg==
X-Forwarded-Encrypted: i=1; AJvYcCX/xynEgEyMjm0nz/zdh/PbyQlRbHnOpKlVgk/+B9/kAY6X0VQs+WD7bNdHuDXZFsPQtXuFj1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4iZd37kvuvoZJ9MZQyGMrO7BgNdZgbYDGJb+RLoVUHt+aqakb
	/HehLRx4L6pTnYqEEyJm4QL/Ppyzpy2esJxqiRzl0VUjgZ5OhIvx+hXcdUBvXycejLMORwXasvL
	M8SHfkcQbPw6O6Snv6N9Febw6lEQLqMIpESZqHtLl
X-Gm-Gg: ATEYQzxh/y+ojamYxmgawQoL3bIuL1HEwSwk8F+UJ2Rvd/trCrQia4/Q0UAGgMRErV1
	Va4ZrMA///iZk/svhWLgiEOIgjCEUN4sU1CiWVgBhyB05fzPu13cwh/BhLMo7+VhwnY7xUwFhHQ
	4HHAKwJC0iqTElZVGagNz1MFfS8tq8CijBAtdkM2JxnscnbIKyi7pNi5BA+kqetpZkp5nRwF1ZJ
	3RIAb5fOzF4Fsv3OveDmwOLf2oQOdE/EVZHAyNk6kjf6Nkrme+o7rTQ2IVeM4qvz4whuOmNp41E
	JYv4xmauiUxRkP09SbY7UTcY3/mAva6Unl7MlGZHxTTFzG6DlC9OWZvvZapIIF9VBtNQOm9Hfcw
	LzohMKek=
X-Received: by 2002:a05:7022:6b86:b0:119:e569:f60d with SMTP id
 a92af1059eb24-128c2d8fe00mr474098c88.6.1772775039009; Thu, 05 Mar 2026
 21:30:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co>
 <20260306-unix-proto-update-null-ptr-deref-v3-1-2f0c7410c523@rbox.co>
In-Reply-To: <20260306-unix-proto-update-null-ptr-deref-v3-1-2f0c7410c523@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 5 Mar 2026 21:30:28 -0800
X-Gm-Features: AaiRm50jkjo2D8__HZfvwOMuhiWP6gML_uFOzVrw-NUHlbujLc2OhzKbo6rD-x0
Message-ID: <CAAVpQUDmSyxGHuyZNGbsbadXBO3yG0qffaeA0y4AzQiSg4v17g@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/5] bpf, sockmap: Annotate af_unix sock::sk_state data-races
To: Michal Luczaj <mhal@rbox.co>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Yonghong Song <yhs@fb.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Cong Wang <cong.wang@bytedance.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 79EF521BB83
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264675-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,google.com,redhat.com,davemloft.net,kernel.org,fb.com,iogearbox.net,linux.dev,fomichev.me,bytedance.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,mail.gmail.com:mid,rbox.co:email]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 3:31=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wrote:
>
> sock_map_sk_state_allowed() and sock_map_redirect_allowed() read af_unix
> socket sk_state locklessly.
>
> Use READ_ONCE(). Note that for sock_map_redirect_allowed() change affects
> not only af_unix, but all non-TCP sockets (UDP, af_vsock).
>
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Actually TCP path also needs READ_ONCE(), but I think
it's okay for now since this series focuses on AF_UNIX.

