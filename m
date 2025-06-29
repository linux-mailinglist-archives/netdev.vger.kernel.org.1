Return-Path: <netdev+bounces-202290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF30AED147
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 23:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB3A16E883
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 21:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEFB23B621;
	Sun, 29 Jun 2025 21:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="c3NpKrLw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86794A0F
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 21:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751233234; cv=none; b=A+2ksBGQqDLE9zciOHMO/JQK2N9mSHPYnXhAROvuAZ8uUTsf+V5rHiLG/mGcOwbYBHnf0gS/nrjnGg2Veanvj4fCEqPp6HFxXShweDxKjGz5VgCtiTgE24xkw5nmAFo17zSiJ6nNYYmJgP0G/PFpfwuondN0nVrGxtsHexQD2sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751233234; c=relaxed/simple;
	bh=IUz+Ldn5aWRzyc5QAomsSRWnSg4dFY9j+XF+d/bNKi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XysJYljkoklg+751kdAvQNKPbvVEejMGy/PtgcZRumY4gf+QDwIde6z3O8uWY4t43kFGSpzs3eqdQPhLcLRyE13+w2RoRXKM8zmId6Kl1CmtihdY7woKAVZ1+C9B9iZo0JG0Je0LPAf7T8JPiiqpeZjMhX+82sEA+T2eoEsva3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=c3NpKrLw; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 391D53F528
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 21:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751233222;
	bh=ULrFLuqX3/N7L6TuZDZeaHi7Yu9t10Q32tC/ZUt/0lw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=c3NpKrLwY7ktu2oHsD7TtnL1/O56gs5PE+pzvY0jUVRnagoxDHDy56NqbcuNV0mHx
	 CcJHxdRl1tPVvTAN2mWGMRztZsz3PlYsmdLlkrgqDr+7jBBVf5DLYZ+QgPVU1CFVGf
	 QyVWkQ4B2rxSi4hNmqj6FMsQcjLqyt83VIxVl/H7QzwxpY96lcHBI93kzkaFmQ79Kb
	 0eaxHTovC7VssEzKyxodkufPTEnGKJZRXTw65WDQgAaezMg0Lg8pj1s0auoopOv0ou
	 nDTHnpxw4UjikGRyrjH7FXj3nSFl4dPMntjKQN12RFas8W42Eul8tVK0bsbnqRWhFM
	 gudPWWuhTuX8A==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ae0aec611beso101173566b.3
        for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 14:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751233221; x=1751838021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ULrFLuqX3/N7L6TuZDZeaHi7Yu9t10Q32tC/ZUt/0lw=;
        b=AMhk2KTtm2L+G5baVnX8fT8KYrWxVMHCUay9NxgMiiYu3Ek50s69Rh4KrzWSgNV6gP
         sK0+GZWUatSEG9+y0EGUMJiGeqLoWsjjxZ9sqGGLZNRTBzPF/ZsRSHAVPdedsYbkyuca
         DI9Ami1XMMALqijI2SpZQMk+RrYdQqwqs+LdEICErWd0NCzRqpgpCzXaN1RexAPuRX0/
         2GjNzTpvi88PylV264dvIrqBRlmbGj3aT85M4WKrCZbrtUSH5EQV7vXyNbRKPhP+zgA/
         v3WEAxcqh2gmSI+uN9q1B5cujIp1nwTLyCc8efI4vsnNjVjOPr64PSDdtP7EfVSUeCpo
         CUqw==
X-Forwarded-Encrypted: i=1; AJvYcCU569frIIxdYNF7VYiN+tIzZuOZ/4imdnqjAB7tG3W+kPU6IgQ/c43mfvxje+J+MCsdhHlMF50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhso1CJwhlM8n6sT/aaxbHrmixuTgMYekR/9ZmBhfh1Ie1/XTM
	0fwQLD+wSnq5F1YQnhZ7pNiVeBXJSdnh0umEqwPSpyvjDrSElVV86NKbQFX5CICoF1YqLiV7443
	YtK/bEcaX+vsTaSurTwHa3iO5GENJ3IS27dQTpZzYZgJr1K1cKItBD4iAPaVhgWh8YkQLMGxjYQ
	==
X-Gm-Gg: ASbGncvgsX1TxV/RodoSUb4ShALzkMJU3i9YVQDz8SuGQlIt9U4kSCy7NO2ykzDDlsl
	zo7bzum9KiibBFqzvejG8KoYNZz+OxCIQjge1drEDi+1jKuj2ypQHnQiEX1H2mBaT0J9agpmjHk
	EnvifRCK0DRraaJQdMFqq0cCIANsUOXci989AlC4ZQ1WPGyiDo7JAf1RUQjhGnGK/hhp70W5PCe
	LPNELIYJ+DuTiiK0l3hi/wYJPpjwv/lMgQXV8bABJfT6s4HpBTF2ibQj0ROfd4Wyv9TAuU/CuG9
	YGyRpa0gsy1U8SVzlM8ZVdBOQxHmFHNNy/BY5LX4JPq3ZKS4rA==
X-Received: by 2002:a17:907:3c8f:b0:ae0:bee7:ad7c with SMTP id a640c23a62f3a-ae3500ffb84mr1000793866b.46.1751233221387;
        Sun, 29 Jun 2025 14:40:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRrsRwdjgiUbLf7LNbT+BKrfksSJYA7P4zBzKzhpPcr7lZkTOV6E3XJ3B/VDKZULjlvomnXA==
X-Received: by 2002:a17:907:3c8f:b0:ae0:bee7:ad7c with SMTP id a640c23a62f3a-ae3500ffb84mr1000791266b.46.1751233220952;
        Sun, 29 Jun 2025 14:40:20 -0700 (PDT)
Received: from amikhalitsyn.lan ([178.24.219.243])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35365a754sm557263366b.62.2025.06.29.14.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 14:40:20 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kuniyu@amazon.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Luca Boccassi <bluca@debian.org>,
	David Rheinsberg <david@readahead.eu>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 0/6] allow reaped pidfds receive in SCM_PIDFD
Date: Sun, 29 Jun 2025 23:39:52 +0200
Message-ID: <20250629214004.13100-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a logical continuation of a story from [1], where Christian
extented SO_PEERPIDFD to allow getting pidfds for a reaped tasks.

Git tree:
https://github.com/mihalicyn/linux/commits/scm_pidfd_stale

Series based on https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs-6.17.pidfs

It does not use pidfs_get_pid()/pidfs_put_pid() API as these were removed in a scope of [2].
I've checked that net-next branch currently (still) has these obsolete functions, but it
will eventually include changes from [2], so it's not a big problem.

Link: https://lore.kernel.org/all/20250425-work-pidfs-net-v2-0-450a19461e75@kernel.org/ [1]
Link: https://lore.kernel.org/all/20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org/ [2]

Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: David Rheinsberg <david@readahead.eu>

Alexander Mikhalitsyn (6):
  af_unix: rework unix_maybe_add_creds() to allow sleep
  af_unix: introduce unix_skb_to_scm helper
  af_unix: introduce and use __scm_replace_pid() helper
  af_unix: stash pidfs dentry when needed
  af_unix: enable handing out pidfds for reaped tasks in SCM_PIDFD
  selftests: net: extend SCM_PIDFD test to cover stale pidfds

 include/net/scm.h                             |  46 +++-
 net/core/scm.c                                |  13 +-
 net/unix/af_unix.c                            |  76 ++++--
 .../testing/selftests/net/af_unix/scm_pidfd.c | 217 ++++++++++++++----
 4 files changed, 285 insertions(+), 67 deletions(-)

-- 
2.43.0


