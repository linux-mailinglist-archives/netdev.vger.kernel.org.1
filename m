Return-Path: <netdev+bounces-293838-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCPBEImzHWqkdAkAu9opvQ
	(envelope-from <netdev+bounces-293838-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 18:30:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B28622929
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 18:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4AFBE30022EB
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 16:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF352D3EF2;
	Mon,  1 Jun 2026 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CGS8SSs1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28082BFC8F
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780331340; cv=none; b=CNwTq9tH80DOwR+VIKzOdU/2Qo5pmGW6jaB+lOGvvAspbD0fMmimpBIJ0QvEk0ZlFEeDnHYDgQi8lD8Od+R0MQetciR1ZBmpDdPe7mR2XNGyXBlmgPLuZ63X+aVbfNlb64kHVtzZ0WUjuOdnuW12YvYagMOeZLFTDCR+bQwEt98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780331340; c=relaxed/simple;
	bh=JHA8A2LqDoxqFwpttDeYSscr29A5V44SjxGPurj2m8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHmkp57XwGcDvpf+Rvh4j2ljJhwN6vfEb8lYOXRF1Dh6KtvCNARI4OMDV1Zk0SElvALXsvs0WIbccFao/CLtlgIJ4c2zqV+5TPyH/TIpdxz0diTHPxk3gVOkaCbiSYoajq7NHYmrs3Mlf1XqflxSpM3WWj0APVrbo1dr8x5k0co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CGS8SSs1; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bebde89cfd3so241013866b.2
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 09:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780331337; x=1780936137; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K5aZ4vAk82i6DVnbVmOCwCzllylMU3ucK3p4smWm5Ow=;
        b=CGS8SSs1SYCTto4oOtQFfOzfHm4agUdfSJLvphy+q6X5po7e0EFVRPjdQ9h9bso9QS
         t4imnCwY9+WCsiVyLSN9gLDiCySZNm8FiX9KhqtcqgEglnJpO5RBTHRMC8t7CkiijgCe
         wIQwm+EnYRnR+LFFOb2UK7CQQsFGE+HpvDLI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780331337; x=1780936137;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5aZ4vAk82i6DVnbVmOCwCzllylMU3ucK3p4smWm5Ow=;
        b=gplyV8ibutHKLEsA0zr1ACRp65V6ppI4gZTLrY4DcAhXVxia/csCvmv7pdNhDfIyKd
         RvfOogixgloFs/Ie2x3Wo8JmkNsToGq2eB0KBFK+0txWpn/+2A7X+HNt6hOMhoS+juH/
         QCHHUYY/oIbI8QSaPx+3mFRSwRDOZfxq6VL5TFttioWuVDUzT4Htc6/YXhXkNXzWLTxB
         s/Mkdt9dNf0yZxvjDa71tKX30CTleB54DzZnEspy+vTQR8840b706zWKAOy03svg9iEe
         PQ6uLPeAYKwsLZKOTFboc2A29mmgMd0Ezm1jrV/dsVaQ/gQyymg8TPhl8QR9X5He0zvv
         MLhw==
X-Forwarded-Encrypted: i=1; AFNElJ/OmZOQc7oFznVmP8kZkbvD35C+992h90Y+E1c7DM0jD5PBO/ipJ/JKqtoQQDK0pwiUKE5D43s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqWXRySWXUUgRHX9HkriihLuEcbT/zuF7lNrSmJ1NNoQF7OSfj
	/qk4KzRgVDFIScXCp2M7KY6V2y0eA6+b0+RFFWVu6zf0xrN0oTqVDM0CbyOkt/k8v5Etteyt7qu
	HMj62iDA=
X-Gm-Gg: Acq92OHor4Q7buaYGhPTZErSkVh8ilNMwqkqk2CsswTJUNqFjCATPoFXvJk8WfQbeax
	1bERasffOijGRgJCUtvNSYyiXYb6aGNzNTEesbajIrbJqH1Ngtse6Lx6ylXaKrNBatMNYwnLEfj
	2yH+T1MoojLBFVHBsLKKrbM96+bEo9viTnfJRCrkMml7VmNbyFOk8KgX/HluVbsRsMyC/N+ZWC2
	sYejySoE3dwSKPRl9blnO6z/pEQMu8i+a2hmyaQnax1gZJ7Q9d0J5WIuQUcuzRAyq9gsHQjb+bz
	fdGXHVeUO1qbHE6pzhAOChP1TW8UPBvgBiMandMCXT592ueQ+m1D1u7ZVffbnjmZQwwaX2LXw4o
	RGhELYMMB2bbLLtEdvjZDuxpQPVrhNg6+/fUi6Ye87nD1mE/hkfeaklNxplXSupHnYsyfNH3SEd
	/Cj9r++oG7rSwS14n9DGKob5o36Cod4fkGCUzAehk9YlMMQy3AK3ja2z8zXVhOSIQxBfA3OgM58
	QNDuJ+xcDA=
X-Received: by 2002:a17:907:1dc5:b0:bee:4562:3308 with SMTP id a640c23a62f3a-bee456234a1mr154419766b.26.1780331337170;
        Mon, 01 Jun 2026 09:28:57 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bec36d91681sm196711266b.45.2026.06.01.09.28.57
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 09:28:57 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bd8d0e4e341so2395463966b.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 09:28:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/jo80O3ZZ1w8kHhdxgeAWksiTLTjkC84t0rzwwZfDduD94xtbKpaUEB23bJXcFj/vUWCrax3o=@vger.kernel.org
X-Received: by 2002:a17:907:3d45:b0:be3:b3fb:e2 with SMTP id
 a640c23a62f3a-beab207a691mr724400066b.32.1780330992765; Mon, 01 Jun 2026
 09:23:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <CALCETrW__=8mSusayfXG7UFCfue5BGbx+vqESj1d9wqOfX4s8w@mail.gmail.com>
 <ah2nBAdsE5vVJ2PL@casper.infradead.org> <CAHk-=wiFuud0Nn3B9YpTWyQja08TeXVk2AB-aAkmVXyigOagbQ@mail.gmail.com>
 <20260601-aufweichen-dissens-ausrechnen-0d9b84728113@brauner>
In-Reply-To: <20260601-aufweichen-dissens-ausrechnen-0d9b84728113@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 1 Jun 2026 09:22:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1dSKpF=NMJmm9d-7kJY=BEVkchTaxsL1LGL3n89KtBg@mail.gmail.com>
X-Gm-Features: AVHnY4Kn-EiKMLw7r2InJ00RsvMx_ZNQz4aALUAoaty1wqi8l1c2ToY4hj4PgVo
Message-ID: <CAHk-=wj1dSKpF=NMJmm9d-7kJY=BEVkchTaxsL1LGL3n89KtBg@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Christian Brauner <brauner@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Andy Lutomirski <luto@amacapital.net>, 
	Askar Safin <safinaskar@gmail.com>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-api@vger.kernel.org, netdev@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293838-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,amacapital.net,gmail.com,vger.kernel.org,zeniv.linux.org.uk,suse.cz,kvack.org,kernel.dk,redhat.com,linux-foundation.org,kernel.org,suse.de,szeredi.hu,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: C0B28622929
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 1 Jun 2026 at 09:17, Christian Brauner <brauner@kernel.org> wrote:
>
> As usual I would argue to accept it and revert in case we get actual
> regression reports...

Yes, likely the only way we'd ever find out ..

          Linus

