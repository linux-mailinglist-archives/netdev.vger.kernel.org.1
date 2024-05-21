Return-Path: <netdev+bounces-97391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CA78CB3D5
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 20:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62FB9B2269F
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 18:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C0642077;
	Tue, 21 May 2024 18:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ayD/YF31"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051C81FBB
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716317293; cv=none; b=C+5BshbXRdg8fYYluEiuPSNDABY64e6k5MvyAsZw7GwcnNDVh9y4hEVCvQITMUAABz7wIGTQiWVf1extYhhu/JpYPy4WmcsXyIf7aGRaJQybmVmZIFp+Ksu94UMLqruc+DmWssy6/SaH4E0YAPstq1mDoJm9aJQQ9jJmM1rhrqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716317293; c=relaxed/simple;
	bh=LNVqPFrD15mPoYptpTPAV/FgXo4EuDLhS2IHIgpVvVw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zk8XxrQ6eS2WW+srNq01ZDbVCcyAaiEZFjsQ3YGgBnGTatIH/tcjyqypybCzJYkcVES+3BonM6LvIFwj7GXHs0C9b5sCskrLw0GF0fidrcbM142AjJwUV/tF4DWlfvQKfbC4zFpTIKZEAoHgyN3QQppVzK8WuchxGyGSkarnjR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ayD/YF31; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59a0e4b773so878529466b.2
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 11:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1716317290; x=1716922090; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TBBomwXn0DM772nuekwi6UD6QZQUxUGf+kbYusNDyPI=;
        b=ayD/YF3115BrqUUzwEzRCv6B4c/SjgTh1R84kInti8wY+nmDiIDNrre4Jq/dQJAv6/
         Dux5BQh6TCKEejQY4P0Hdd2fezHhlpFVqblIHl/MVnWRyWEERJuRQwbwXik90cgi56h9
         Pia0xrXmYECixJi+c7ZY4AB4qah089tZKhoWZ6p/tlUiV9QF8QBU+gyPiBpGuVHrfrzq
         /7Jo89p9nXQyrzSbIevd4X8mfWo6z1+wDMJVBIZFw6NhgPAdqJoizd0KUW5lrBNNIWAi
         Q6yjsWfzKNVO/Apoe4ZFM64ifyfxc/+QmXhAODbmoq5qh6ouB3pYBVg5qvaipHcgOTDM
         fLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716317290; x=1716922090;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBBomwXn0DM772nuekwi6UD6QZQUxUGf+kbYusNDyPI=;
        b=SjgC2ykEXoB+aKjIWeD3OaQZWT/S+MipWcwhwQ8bqrrCugnNkcOgO5DK1SRZADcj7b
         K23znddZ6xjIJSry/ARkYgsJ4JsIGzgJB5daMWv90lEMKPTS/FY/q/gD96A8dWannPE/
         vKcLS/whI3uXcvJ3lV8NLC12novqyPU2tAGKHVOyjUEreuSI+ioU4Vxe3+139YcLcD68
         1OPWMbzz+faPFW5oXcDe6M24I+tnTzcpYaw7bXvm8oVS+xcCbZ39zsYsiCweFzZFU/+g
         3spJMHKOHkVMZVka/0JuEVT5O/vy/Kcg469zNqAAqm2iKlG65AzoMDWhmcrjVVAg7I/4
         7OwQ==
X-Forwarded-Encrypted: i=1; AJvYcCURj/tAl4fl+amdAcB8aGw/eysU0snE2kDbZQcyEX39th7Iag0bbNFP/frF8FdPjBliBi3O2Z2BtWrNex2wfqAMn/SGqHOr
X-Gm-Message-State: AOJu0YwNpxd4/gAbkAAc1VjovWJVpJtBe4FF1fHSgasuUHXBESwrS8I3
	yxYovIlCN0Dd4Pz24R8OOsJzpV8KL8upaNdHwhX3MLp13QQS6rn3+XSrnwG7fwI=
X-Google-Smtp-Source: AGHT+IGwzI5vKnF5RscLl5qzclGErCciKuC7xjKohu60VtKLxkJ4nTDhs+enXEqJCFYG+J00QOQiTQ==
X-Received: by 2002:a17:906:81d8:b0:a59:b784:ced5 with SMTP id a640c23a62f3a-a5a2d6797f9mr1904402666b.67.1716317290430;
        Tue, 21 May 2024 11:48:10 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:3a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a7b53fc8fsm1049418566b.38.2024.05.21.11.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 11:48:09 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: syzbot <syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com>
Cc: andrii@kernel.org,  ast@kernel.org,  bpf@vger.kernel.org,
  daniel@iogearbox.net,  davem@davemloft.net,  edumazet@google.com,
  john.fastabend@gmail.com,  kuba@kernel.org,
  linux-kernel@vger.kernel.org,  netdev@vger.kernel.org,
  pabeni@redhat.com,  syzkaller-bugs@googlegroups.com,
  xrivendell7@gmail.com
Subject: Re: [syzbot] [net?] [bpf?] possible deadlock in
 sock_hash_delete_elem (2)
In-Reply-To: <000000000000d0b87206170dd88f@google.com> (syzbot's message of
	"Fri, 26 Apr 2024 23:08:19 -0700")
References: <000000000000d0b87206170dd88f@google.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Tue, 21 May 2024 20:48:08 +0200
Message-ID: <87jzjnxaqf.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 77da1f438bec..f6e694457886 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8882,7 +8882,8 @@ static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
 	enum bpf_attach_type eatype = env->prog->expected_attach_type;
 	enum bpf_prog_type type = resolve_prog_type(env->prog);
 
-	if (func_id != BPF_FUNC_map_update_elem)
+	if (func_id != BPF_FUNC_map_update_elem &&
+	    func_id != BPF_FUNC_map_delete_elem)
 		return false;
 
 	/* It's not possible to get access to a locked struct sock in these
@@ -8988,7 +8989,6 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 	case BPF_MAP_TYPE_SOCKMAP:
 		if (func_id != BPF_FUNC_sk_redirect_map &&
 		    func_id != BPF_FUNC_sock_map_update &&
-		    func_id != BPF_FUNC_map_delete_elem &&
 		    func_id != BPF_FUNC_msg_redirect_map &&
 		    func_id != BPF_FUNC_sk_select_reuseport &&
 		    func_id != BPF_FUNC_map_lookup_elem &&
@@ -8998,7 +8998,6 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 	case BPF_MAP_TYPE_SOCKHASH:
 		if (func_id != BPF_FUNC_sk_redirect_hash &&
 		    func_id != BPF_FUNC_sock_hash_update &&
-		    func_id != BPF_FUNC_map_delete_elem &&
 		    func_id != BPF_FUNC_msg_redirect_hash &&
 		    func_id != BPF_FUNC_sk_select_reuseport &&
 		    func_id != BPF_FUNC_map_lookup_elem &&

