Return-Path: <netdev+bounces-278332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBrwDGD33WlolgkAu9opvQ
	(envelope-from <netdev+bounces-278332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:14:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4E53F7065
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40D6A30D2C91
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 08:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B9638E5C5;
	Tue, 14 Apr 2026 08:08:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E131C38E5F7
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 08:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776154090; cv=none; b=k6mmzVFx445jP3FLUowqTmP76ELYk13tpBj/QJ/6pPVUG8V412l+X2MatgX5xiq3JRv8SzWLfsMwxDD76mtqW2tMJz+I5xkvztZmT3FH4Z2VHiEQH8tPNQxYUK8p2QstxudMr8obgnyWHw63V0u/hqViBMJu3EmkqYU/M9RlEl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776154090; c=relaxed/simple;
	bh=NCU7HC1t3iEDC4IqX2izve0FBoiDBcxRNyhBdT9YCoc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=sK7/tvRRY0GyIsVjatPO1GAvf7xWZdnZfYe+A3jVYQUvAJfzd2G2VbHsbvgAgQK9PS2EVFh6m+gzSKf17Lc9mhTKVYXSkbjC4L0SKzm1H0Tf1FuB8SvGRNCQspBihylr/yEGSrN/Yy62HgPgvHF89aS/bK9/S040pg+zXBQInIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7dbe11b1f03so1354215a34.0
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 01:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776154088; x=1776758888;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NCU7HC1t3iEDC4IqX2izve0FBoiDBcxRNyhBdT9YCoc=;
        b=Z0/AZYlsjhQAoBf23V3/lAgQ5ROcxO0pq9WBXFCmACN3fQhvSGByub0gLQW1PEpICN
         ib2Zuvp/aG/jfG80PEjs5jhEEhOql1y+aG2jxFUl90z+3UJatBtpG3suaP73U5B0FtCE
         5MldzuAC5KkWsF7/7VFauZ9NDqZwat0gr0zFVu+HoZ8fzDcs0iJwOwSHj6oJm73glmg/
         oyM7S0FlAlsAdKcluxXxHpeBeeXuATWF8jRSr/3424HRQu+LctCPm8rgycQx4I0MuDks
         mYkXc8/wuJCt2x0mpdGtm8JaX/Ik5qzXrfKpHQcAPtcxnZPvYmEQWPVDNV7NIkJNJx+v
         Xmng==
X-Forwarded-Encrypted: i=1; AFNElJ8acwTEyQn+VPpJ8n4S3VBxS5wV/CXMmeo5MThPbZqyj+v/gea+T+7PuY9zaELKbWRUNaD6T7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymx8w/lWK7ksKmlVaLlexgGO/aA+I6mVfclJl+3iJQjsO8gKYY
	0zFtLnnYX1k2MI4owKCdVaGPJ0Qr3sdXgXCjuT4rw1nf1t1QsdJ2mIbsUp+BhwzJ8qpYoU4Iotc
	uXmIaAKi3iikOMNCvxd+NbOPIeSkj+OvcQuGuhXxPjNBk6uSH9tGKM2mDZ4g=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:8183:b0:67e:1c67:ebd8 with SMTP id
 006d021491bc7-68be7ee1b88mr7508599eaf.40.1776154087806; Tue, 14 Apr 2026
 01:08:07 -0700 (PDT)
Date: Tue, 14 Apr 2026 01:08:07 -0700
In-Reply-To: <41689f2e-8786-49a6-912d-f65e48245a61@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ddf5e7.a00a0220.468cb.005b.GAE@google.com>
Subject: Re: Re: [syzbot ci] Re: veth: add Byte Queue Limits (BQL) support
From: syzbot ci <syzbot@syzkaller.appspotmail.com>
To: hawk@kernel.org
Cc: andrew@lunn.ch, ast@kernel.org, bpf@vger.kernel.org, corbet@lwn.net, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	frederic@kernel.org, hawk@kernel.org, horms@kernel.org, 
	j.koeppeler@tu-berlin.de, john.fastabend@gmail.com, 
	kernel-team@cloudflare.com, kuba@kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me, shuah@kernel.org, 
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,vger.kernel.org,lwn.net,iogearbox.net,davemloft.net,google.com,tu-berlin.de,gmail.com,cloudflare.com,redhat.com,fomichev.me,lists.linux.dev,googlegroups.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278332-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F4E53F7065
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Please attach the patch to act upon.


