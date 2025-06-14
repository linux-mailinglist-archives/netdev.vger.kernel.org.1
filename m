Return-Path: <netdev+bounces-197759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E14E9AD9C8E
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 13:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15677189440F
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 11:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BB62C08DE;
	Sat, 14 Jun 2025 11:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="S7lDe5Vw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494202C08D6
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 11:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749901432; cv=none; b=dIEFtzh5WF6GgVekH+h4zm3UwHdunXc0fwjPC3xmKqkkg4UShPZ2EVPgR0Rcoq8dglgCESlV+bPMufjmDGC8RC/qI5W7Im46ug3vgu7p3LLw1zAT7LXzUZVuxaeC9xaJ3CCYzpET22EPY0+UbYzC72iQK7QJf7h5nYyb6B1tBkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749901432; c=relaxed/simple;
	bh=OoaoWMKFCn2qhVp1/VrgVw6hYnU7LgLNGUrn+S2eYOg=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=XTFpO3NDKVf0M8SvOr5zxZVbPuK7soeKm5NK436iazIlmWgvZQamiGmh1yoSpOdSdVjpLIzY7s6X+kQUF6MlioUN5HMyUxaa4HjwuG8iU3Eh2lDFQxD1/KJHh9xuVs+VnTlrxGyuGXZOGRJv65IoBqQ5j6GeGj5uRR/zJbh1SD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=S7lDe5Vw; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6fac1c60e19so42686676d6.1
        for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 04:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749901430; x=1750506230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BeA+cGdqkFUYAZOJspNOScTIdPqYIEy6/Lha4BqMN50=;
        b=S7lDe5VwURSoF5/dzDFqKowIXDUPGvLarNQJNqnkH7n50DG62mWnQeXV6E6mbQi099
         5BYrcxFUcpomrdZeRy9hW5yBm1r8F8PthUmJVclRLocYm9TuLiDluyL/JGcoyQM0QIRC
         uBRRD5SkMMFVPEWoOE9vtsEeiS5dPwByArHrpIr/J4QGGXl06Iwe3glJgHP8AQcP30VY
         HmUfK1xY/lhK0tHhw2nd+SELJRYYKzKZpvwxc0C/Yskzp+jJU69YyKjJ5wLqssTbGgTs
         kae/58AYfPyiHxNxuSbP1gwoQTq1BYw3I+n6zMZ6opIktT5rVIG+nEL7sxO/aQK+QAgM
         CxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749901430; x=1750506230;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BeA+cGdqkFUYAZOJspNOScTIdPqYIEy6/Lha4BqMN50=;
        b=It8jkSxbWa92s5iVJq0luzo5+NMVCQgPfDxs5Xqir+mO+J6k4VYHu2CDR+hVvkNb/I
         1XdfI9PrsuljfCM6PlKHkyiGzUpH3ZCtJsUQkmgBohAA1ZRZ4U+57PNQ3jukDfgVJt3E
         61cbIZyMPb3VyNl7pKaS0AfhsKMN+ERKJR3NMBKmONxekiiJ9vBbFfojbbrNJH+pJ6gz
         7C6wBo2dZUZIh+cn5ijqGcrZfEZWnI/hNoLSlVNQfkxfiEuwKmNo2zrL21eOKcPl2vGu
         nJdyUCA6g6Wnio6qxzwsCWY5LH3fJd5nkk7zOC/3fM3WpBu4SvxcexNgxl2+1cu4G1pB
         +f2w==
X-Forwarded-Encrypted: i=1; AJvYcCUdWGmLdCAhOjSY1BrKVmg8W9S+7v+WNNdVq/HtEY6ZwWEYdQsYcKITTWJ4R6ussj+U38+K390=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJAlJfi25Tott1caKIUDz/FylMDZKIffGnei1BY0RPKYji6l7v
	hU4Ez8O5Wv/RyhPKT9MCz9k2bGTwWoHLh0ExVW6Csw87ECYgp62nse4cxoE8cCSFkQ==
X-Gm-Gg: ASbGncsefvGOd6PKXvuGE4JGvwgsbt+Bdzx/cHhhVdi1l0XiiXVeLfWJYjfDqSLx2Ik
	+Epmwgx6+TpYkykb3YhEMrD/HwyOJGE/6QZQjxi/uppsMh89KOA7Hui0djkNSLIH5FbcbzYxSfv
	RB7rUfiIphV8MVKqJbONS605xnecJnF6gnD7/pzlcon1dKoYl+7VqHEa6a0ZMBj6i/a1Putx2mF
	O8WM4UxqUoG6KgboPNBluIP0Vs+QxaRxldTKyidEsZ8L3KuLVO5p3ON6o5mrEwkCpzTsYpcz/VD
	6fSFvsl3zTD8i87FZhRo1KxrvYSo/mVpiq0ljS+xtCJm1oidMQrORSG7C3dU
X-Google-Smtp-Source: AGHT+IEQkio8IAsbWC+2/pmCx/HPxSFcQrkjBZhZlMj0S8DQlrj0v+c53BCsuua9D4ior6VqPrPncA==
X-Received: by 2002:a05:6214:c67:b0:6fa:9909:12ec with SMTP id 6a1803df08f44-6fb46d4cf16mr47126126d6.2.1749901430110;
        Sat, 14 Jun 2025 04:43:50 -0700 (PDT)
Received: from [10.27.248.53] ([68.216.65.98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb48217708sm5972566d6.78.2025.06.14.04.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Jun 2025 04:43:49 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Kuniyuki Iwashima <kuni1840@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
CC: Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, =?UTF-8?B?R8O8bnRoZXIgTm9hY2s=?= <gnoack@google.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, Kuniyuki Iwashima <kuniyu@google.com>, <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>, <selinux@vger.kernel.org>, <netdev@vger.kernel.org>
Date: Sat, 14 Jun 2025 07:43:46 -0400
Message-ID: <1976e40bd50.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <20250613222411.1216170-1-kuni1840@gmail.com>
References: <20250613222411.1216170-1-kuni1840@gmail.com>
User-Agent: AquaMail/1.55.1 (build: 105501552)
Subject: Re: [PATCH v2 bpf-next 0/4] af_unix: Allow BPF LSM to filter SCM_RIGHTS at sendmsg().
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit


On June 13, 2025 6:24:15 PM Kuniyuki Iwashima <kuni1840@gmail.com> wrote:
> From: Kuniyuki Iwashima <kuniyu@google.com>
>
> Since commit 77cbe1a6d873 ("af_unix: Introduce SO_PASSRIGHTS."),
> we can disable SCM_RIGHTS per socket, but it's not flexible.
>
> This series allows us to implement more fine-grained filtering for
> SCM_RIGHTS with BPF LSM.

My ability to review this over the weekend is limited due to device and 
network access, but I'll take a look next week.

That said, it would be good if you could clarify the "filtering" aspect of 
your comments; it may be obvious when I'm able to look at the full patchset 
in context, but the commit descriptions worry me that perhaps you are still 
intending on using the LSM framework to cut SCM_RIGHTS payloads from 
individual messages?  Blocking messages at send time if they contain 
SCM_RIGHTS is likely okay (pending proper implementation review), but 
modifying packets in flight in the LSM framework is not.

Also, a quick administrative note, I see you have marked this as 
"bpf-next", however given the diffstat of the proposed changes this 
patchset should go to Linus via the LSM tree and not the BPF tree.

--
paul-moore.com





