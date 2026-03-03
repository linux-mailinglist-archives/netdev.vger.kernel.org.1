Return-Path: <netdev+bounces-262994-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDw+JuBHpmlyNQAAu9opvQ
	(envelope-from <netdev+bounces-262994-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 03:30:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECA11E8127
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 03:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AFF63044B4D
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 02:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4F8375F9D;
	Tue,  3 Mar 2026 02:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JfPMs15Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D398375ADD
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 02:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772505028; cv=pass; b=R8MBmqCr1AVAbe5pEiKEbvpzF64RJqNBDFWtnYoWN2UyfsbPUYALiXUghnnh6qmpftm76F5U/1Qxv+QxP6ag/ltdxZ9DsNhx2jYxwyDiixQOfW/uGMo+QZT1v1u14JPGnAfqaW9pr5CaNYaSxsXIVvBX+K/oDyqrP6xvwaWd+tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772505028; c=relaxed/simple;
	bh=dpQSmzkUM5eywQT8MkIz9dqIAPHwbz822026FlJmJ4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAlsa1SQfZbSvf2s4qzVxjXel8mP5EThZm+lE1OurGPCbjLepii67d4ikLWuQJyeJ7N1hXpnoEUNioo5XliDrh7JlDQV/Qw5jFkhSYBnLvTa5pyGEStnBpYAvrDp78g52hnbMcNlWKG2rjsELnzukcvnDO4duV1EojdYcsqay7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JfPMs15Z; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c70378ddaafso3484815a12.3
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 18:30:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772505024; cv=none;
        d=google.com; s=arc-20240605;
        b=ZT8SJubHrX8zDzmpB+EyOo50zB6wgaOyuQFS5VAtXaZpf7vitwNUxUJqlEv+GjRtw7
         8RTZuEUGWyXQQvICHlrdFdORRuzyot0L1S86IlM/6gZxODwo3KeEXUX+QZacqheE+M3n
         HDC2QjwaDz/o/yQTFZO0s1rXAkyoKtS6QJ5wjkp32tLUxlpBHrQPO3UoDjsZ4GdmvLpK
         i5SD7twdJIq7sbVfQlPW8EjX9AXWoDxeN+ERJ7ePitIMT9LOSaWUwQa27b6pviQuWEQx
         rjO/lwH6dtTVATmpbbcth1n4Nxhus7SdRX0Nt2SLdKj0jIBLpAPUmr8qRXIrjy1Fj1Xl
         mycA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VKlMqpEd7YBdXym1IpYpN4BFku3eaQLOirqfkrIT+SY=;
        fh=voMTDkrowhq70btKJqnumao8d84MkC2vlGxfhZddcXk=;
        b=iCAqlPncr7dhieXqzs5fsbQ0/kVe6Bz2wTf0XvnMFpoYsM22zYI3Iloje3ex6ExZwS
         iJteg5pkPGDupiXZnlH+F8b8AQehJ2hW7W1tQkFeMYGgZAT+I9uKWJ7xKz1S7cK98xBo
         DKB7FAdEUxHwCT7SPJm7YALwd/z38ejIHvEEbsl+bhfaEywfCmeeNbcfvW3sP77u7vUV
         ySqOaIIRDojma8L3tr0iYmgYYJIyIJ2xjTrsTBoEL1zs6MlU2IfZEBIR0SkJJWAEcyMU
         Z8bi6wZwIahYpwFJqGhU6M7GIS4WS3wBSzZLbT1zB6hElg/8zPFrWHFWcDrkzJKKkSrS
         1aBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1772505024; x=1773109824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKlMqpEd7YBdXym1IpYpN4BFku3eaQLOirqfkrIT+SY=;
        b=JfPMs15ZCu5uQlmdqQusmBhN/hCtjzE2ILqtdhvnIFAYHSV1FHjmSyA1arRjcsqd4i
         Z4zhEf/tJOotLdNVozbOOjxhBlRwJk71hprzA2SYVvUIKNvz8c/GjcFp3BL7vDklngvO
         zl4V4Vp916TZAWDuaMm3M9LB/UUzTTI4PNa8ZN0UQKnn5dtnNA/PDX+I+seNTfdQA7FQ
         eAeF4P/7MyBqU3rFB/xabPpQJ0tZLgdAdrccAFYA5DSO631fAvLOUoY97xGiqrBBqUXo
         Z1tmyiODc/zF//4CcHZRtYJNPYA1OChITkK1DJK96ljrZqSQHtTgNfr5zJ5nJo1M7dd7
         ac4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772505024; x=1773109824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VKlMqpEd7YBdXym1IpYpN4BFku3eaQLOirqfkrIT+SY=;
        b=HnjhrmqzVNOPNOCOnk6nD+lyF8aLNvmkq60aPdioX847gA2i5pj5k3zxKvGiC7svp3
         QmmJcZIWVye2HKopAaDaRuCGKI1/yx37wF0n+z+jBUK59rsZ3jN+VJBfSE+M7mSxas/g
         L0gamwqR92vaFYnsku2DbXNj59FCmq8XN8lP9Bjzj1vT4ZzOnakB8PDMstZmvLJTOn8K
         fy4JyRiQ2Wbu/JuP2HvoYUuFzpUvkRdd32nxZpLNp+0QN+LAf/RwuI+Ybma6JnIZHdXx
         RjwoCl9Wu2Fy+JC6mjoQtlRBu+qhBWmMbuUMhW61DLwA/TcXU2CBfaPrbqPDiIXcHL0l
         QAIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhhGpHKPP4vQZMArSvM2I9mVEXDt5OgVEXQosFI3dx/mGuqf9kmX4o258QQY8J3MefbEI563Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqVMpvsK9hZfgpYbLwqqNQsnUqgF3n/u+xmcrYCDVYv+ToPiIK
	t/tPR5xj31frOUxbCHq6dTy7mIjJop2qPtbFEAqWN7xJ3vldVMzh+TCH+cbPmHa3NvqyU3kyogD
	WHm9WMusoxj/AWdumhE2KwsmHgZCzUJz+e3sQYYh3
X-Gm-Gg: ATEYQzxSdLpJ9EE2+w/8k/M9NdlxsWF0XVNNbbuuA0WxaebcCUnva8+cDBrrePVYVzi
	EuBU0SUpLvFfIvqJwxYeklTk3oSjlPT6oi4iEVUuNiOzq7vuvf9sA6cuQuKFyyu+infecmOhJda
	SWZ8gUpKPNTkso4SoVIzI322/CpMBZaj8moyXPZYRd2/mwrbGLdYnYVK6v1Qz8IB3mXtkkAZw1x
	f+uOWUZgBMxgVS/iFnSd5R+IJFSNiwqwQ72iwBpuF/ISZk4+LnobPsN1hGQVnA8PftNi6rr3eOb
	IjR/PGNLDu2xj6ubOg==
X-Received: by 2002:a17:903:244a:b0:2ae:56f8:747b with SMTP id
 d9443c01a7336-2ae56f8786cmr37920855ad.57.1772505023451; Mon, 02 Mar 2026
 18:30:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org> <20260302-iino-u64-v2-105-e5388800dae0@kernel.org>
In-Reply-To: <20260302-iino-u64-v2-105-e5388800dae0@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 2 Mar 2026 21:30:10 -0500
X-Gm-Features: AaiRm53tOqTCLn9NgvLgqwCOFo4xSyksjolr8ucn59RQ44Ck0r7mzGeRmSI5U0c
Message-ID: <CAHC9VhSHj7qc-tKxEN45bkfr+Dha59ihzOGiCO2WDYTYoB-LeA@mail.gmail.com>
Subject: Re: [PATCH v2 105/110] security: replace PRIino with %llu/%llx format strings
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Steve French <sfrench@samba.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Bharath SM <bharathsm@microsoft.com>, 
	Alexander Aring <alex.aring@gmail.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, David Sterba <dsterba@suse.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Ian Kent <raven@themaw.net>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
	Nicolas Pitre <nico@fluxnic.net>, Tyler Hicks <code@tyhicks.com>, Amir Goldstein <amir73il@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>, 
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, David Woodhouse <dwmw2@infradead.org>, 
	Richard Weinberger <richard@nod.at>, Dave Kleikamp <shaggy@kernel.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Anders Larsen <al@alarsen.net>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
	John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	Martin Schiller <ms@dev.tdt.de>, Eric Paris <eparis@redhat.com>, Joerg Reuter <jreuter@yaina.de>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Remi Denis-Courmont <courmisch@gmail.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	fsverity@lists.linux.dev, linux-mm@kvack.org, netfs@lists.linux.dev, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-nilfs@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-afs@lists.infradead.org, autofs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu, 
	ecryptfs@vger.kernel.org, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, ntfs3@lists.linux.dev, 
	ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, 
	linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, netdev@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-hams@vger.kernel.org, 
	linux-x25@vger.kernel.org, audit@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-sctp@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4ECA11E8127
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,yaina.de,holtmann.org,hartkopp.net,pengutronix.de,secunet.com,gondor.apana.org.au,fomichev.me,iogearbox.net,vger.kernel.org,lists.linux.dev,kvack.org,lists.sourceforge.net,lists.samba.org,lists.infradead.org,coda.cs.cmu.edu,lists.orangefs.org,lists.ubuntu.com,lists.freedesktop.org,lists.linaro.org];
	TAGGED_FROM(0.00)[bounces-262994-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[171];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,paul-moore.com:dkim,paul-moore.com:email,paul-moore.com:url]
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 3:50=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> Now that i_ino is u64 and the PRIino format macro has been removed,
> replace all uses in security with the concrete format strings.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  security/apparmor/apparmorfs.c       |  4 ++--
>  security/integrity/integrity_audit.c |  2 +-
>  security/ipe/audit.c                 |  2 +-
>  security/lsm_audit.c                 | 10 +++++-----
>  security/selinux/hooks.c             | 10 +++++-----
>  security/smack/smack_lsm.c           | 12 ++++++------
>  6 files changed, 20 insertions(+), 20 deletions(-)

For the LSM framework and SELinux changes ...

Acked-by: Paul Moore <paul@paul-moore.com> (LSM/SELinux)

--=20
paul-moore.com

