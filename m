Return-Path: <netdev+bounces-295725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4dlsJGiMImoFaAEAu9opvQ
	(envelope-from <netdev+bounces-295725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 10:44:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2689E6467E4
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 10:44:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UuJHVdp3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295725-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295725-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E364302E90B
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 08:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52DE399CFD;
	Fri,  5 Jun 2026 08:35:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D87938C41B
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 08:35:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780648534; cv=none; b=lfTGeB59Mn09Bk6RFeBwgd4/b5d/PDVL8xkT8HK3/YpPW0aGpvrukaMAQYhpU/IpRzTuwCbPpy91wLMO9zrEEXMOE2Od2MGrLbfyy0ZmjQPmF9lnn6+3rGFSQVRxmEAQdph9qQ8/FL33eVyAy7VPmb2nNVhV8va1h5/JVydT0OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780648534; c=relaxed/simple;
	bh=lDo/awf12mnu0rXStjbYUQ5yncxlrbhWIgSdHpfq9pY=;
	h=From:To:Cc:In-reply-to:Date:Message-ID:MIME-Version:Content-Type;
	b=kyQieGZ08YzRgCNjgXyIFscvAZ+g/l3CCJUAhUxKIGV/X8bc8BZQRP5Y9P20D7G9QBLvd3zt+PvjqTujAyWGuo08t1DgbpnJcRrnDIL9bsOpSwSWrEXBcikct1ICcuFj8/1+FC3N0lJJrGXaUVUJ3BFtNnu/rdqR8ExN060vKKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuJHVdp3; arc=none smtp.client-ip=74.125.82.181
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3075ce9c05aso2916722eec.1
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 01:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780648533; x=1781253333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :in-reply-to:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G2QbVMMAjVZgPuV1Q0/veKQfSmVHwoFIoMdSdS/WIZg=;
        b=UuJHVdp3tKhT6AAQPnN3VH1SLaVTVJeu9SdL+rDlZeBP0FpYsKaAzlFGvx4DYEk3ec
         UQdgbwulJIOzWNqwVGUuJvQ8K2YgSPJLo/xG6GnBJJ7/poxarU2Hn4YkfmRrpebC5Hc+
         y916et1JSExata7ER1hp+anPEwNXQj9sDI7wcjqNcuHc+mH1D/Wgt33Ml6EjQJCeF9Xm
         7xarHNEU2SmCDhMUHqcdzPnllKDv22SGRMmGBxjG5H3yTtUqnS0UHERJjLPovZ95EG4V
         SqRCJF1eHoo9DiCFdI4pmZzCtVn6A0zo5ld2MaJRhZHsMShrfGoHBetyL2/5Mlybmpj5
         /qSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780648533; x=1781253333;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G2QbVMMAjVZgPuV1Q0/veKQfSmVHwoFIoMdSdS/WIZg=;
        b=p13xWp5waoin7vz5T5vT6URVPCArn2QlcrBlhFNh6SeOOt4/JM1OYhZjv34zLOEzWK
         rKd5lrYfrJDRtY6h1K3tgfg9WbCxz2abgFJ05oyr063FwqW8S9kDRP2Wzo7GR726gvmK
         pxLzvAfSiDOj9kTJ8xm+BOs8Zm27d1FIJjgTmfSi16ZggbBa1glPJTmjUcIIzmHUlULF
         Zdnnflu78hkXW5YahXFbLPkS0u2dYfnGgKVYPgPRR1xa7I1lNBWlM5wRlEM3lZ3Q0FDx
         vgYVa7zd+LZWXf+RAJENYIA+y2cBBFJ3W6z+ixP3lR3cIFP/TD54vE5sAUTIsgPEuKCn
         SQlw==
X-Forwarded-Encrypted: i=1; AFNElJ9BRoccuO1VBROiWIiDvPM9Oj5pWqIg9zAXB5cq2AwFPDzRv4q/Dct8My0KawmgXsLBet8CrDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSBYocr4Eqms4qk5iT7uy50B3AhsSolgjAAk2Gy4IUVBj0aPOL
	3jqXiS+ZySMqaTSSgiFzM/8aUsNDhL3UTmNw7gDp4x5MgR730ArXNWZM
X-Gm-Gg: Acq92OGdZJv34LNnb9ktuoEseLfd9GxwpQUV6RFKwDCqK206q9ayRTYzHUQrNhw1Agc
	WB27+bJ+4GTrJ3piD94OX62dUxfrQVp67gPXK4uKlgjvuK4ZIULbC18PEYFjUewB/5qaS0z+bPh
	7+40eco+yyebL8Wlbt3Aj3RXbfUAdoxuPVqEDwTSZh/DRqnF9z5h/PHwdBY7vii0tro0+yYsf6G
	HUrLJcVHw3jtFVmA0X49/dwI1esBn/qv3qTPtSHW60jbXhJx7TzJzb5QjL/XVvlOwWd7cLQi4jO
	a4joPD7I/rvZLpZC4ISioByhCqGelyciaM25btj9VSMso9bPlUcFsD1qQpzcVBeL1Bfy3sdJ1k+
	Q+THmWCw/W+hOcO0aHEhwNCETRqxtLfSv+4/sY59maaotxUGvxXma4yQkpKDO9Nm3JaJW9TtjVR
	xqYwaIiPExdzc8rZYluoi35jjGeQiPph3gOA==
X-Received: by 2002:a05:7300:72c9:b0:2ea:5057:a304 with SMTP id 5a478bee46e88-3077aeed2fbmr1184583eec.2.1780648532644;
        Fri, 05 Jun 2026 01:35:32 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770:10ff:fc71:c346:9948])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dba046esm6534100eec.9.2026.06.05.01.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 01:35:32 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: brauner@kernel.org
Cc: =?utf-8?Q?P=C3=A1draig?= Brady <P@draigBrady.com>,
 akpm@linux-foundation.org,
 axboe@kernel.dk, david@kernel.org, dhowells@redhat.com, hch@infradead.org,
 jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu,
 netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de,
 safinaskar@gmail.com, torvalds@linux-foundation.org,
 viro@zeniv.linux.org.uk, willy@infradead.org
In-reply-to: <20260601-enthusiasmus-canceln-anlehnen-0e62317a9784@brauner>
Date: Fri, 05 Jun 2026 01:35:29 -0700
Message-ID: <87tsrh8jvy.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_SUBJECT(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295725-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:P@draigBrady.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:safinaskar@gmail.com,m:torvalds@linux-foundation.org,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[collinfunk1@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[draigBrady.com,linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,gmail.com,zeniv.linux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[collinfunk1@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lwn.net:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2689E6467E4

Hi all,

Christian Brauner <brauner@kernel.org> wrote:

> On Sun, 31 May 2026 01:01:04 +0000, Askar Safin wrote:
> > This patchset is for VFS.
> >=20
> > Recently we got a lot of vulnerabilities in splice/vmsplice.
> >=20
> > Also vmsplice already was source of vulnerabilities in the past:
> > CVE-2020-29374 (see https://lwn.net/Articles/849638/ ).
> >=20
> > [...]
>=20
> Applied to the vfs-7.2.vmsplice branch of the vfs/vfs.git tree.
> Patches in the vfs-7.2.vmsplice branch should appear in linux-next soon.
>=20
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>=20
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>=20
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>=20
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-7.2.vmsplice
>=20
> [1/3] tee: fs/splice.c: remove unused parameter "flags" from "link_pipe"
>       https://git.kernel.org/vfs/vfs/c/a9f7db50ed2f
> [2/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
>       https://git.kernel.org/vfs/vfs/c/e2c0b2368081
> [3/3] splice: remove PIPE_BUF_FLAG_GIFT
>       https://git.kernel.org/vfs/vfs/c/7d75aa8edfce

In GNU coreutils-9.11, released 2026-04-20, P=C3=A1draig Brady added the use
of splice and vmsplice to the 'yes' command [1]. Afterward, I added the
use of splice to the 'cat' command, which is now used if copy_file_range
fails or cannot be used [2]. There were some minor adjustments that had
to be made to those patches pre-release. However, as far as I am aware,
they have not had any issues yet which was a bit surprising to me at
least. Now it seems we are a bit unlucky with our timing...

Anyways, I figured you may be interested in seeing how these changes
affect some applications. I built a kernel from the vfs-7.2.vmsplice
branch and used a config based on my recent Fedora kernel.

Here is the throughput on my Fedora kernel:

    $ uname -r
    7.0.10-201.fc44.x86_64
    $ yes --version | head -n 1
    yes (GNU coreutils) 9.11.50-157bd
    $ timeout 1m taskset 1 yes | taskset 2 pv -r > /dev/null
    [36.9GiB/s]
    $ cat --version | head -n 1
    cat (GNU coreutils) 9.11.50-157bd
    $ timeout 1m taskset 1 cat /dev/zero | taskset 2 pv -r > /dev/null
    [9.34GiB/s]

Here is the throughput on the vfs-7.2.vmsplice kernel:

    $ uname -r
    7.1.0-rc1+
    $ yes --version | head -n 1
    yes (GNU coreutils) 9.11.50-157bd
    $ timeout 1m taskset 1 yes | taskset 2 pv -r > /dev/null
    [3.41GiB/s]
    $ cat --version | head -n 1
    cat (GNU coreutils) 9.11.50-157bd
    $ timeout 1m taskset 1 cat /dev/zero | taskset 2 pv -r > /dev/null
    [9.50GiB/s]

Unsurprisingly, 'cat' is not affected since it does not use vmsplice. On
the other hand 'yes' is 10x slower. I dislike this, obviously. However,
of course I realize that the average person uses the 'yes' command much
less frequently than I do, if they use it at all. To them security is a
far greater concern. Just want to make it clear that this message isn't
an attempt at getting this change reverted or anything like that.

Anyways, hope the testing was at least somewhat useful.

Collin

[1] https://github.com/coreutils/coreutils/commit/2b1c059e6a06eebbb721d010b=
1221ec54200cc33
[2] https://github.com/coreutils/coreutils/commit/457f88513a128ce91160c4a60=
f821cc1612204be

P.S. It would be fun to test this branch on the machine where we got
'yes' to output at 175GiB/s. Sadly we do not have root access on it to
install a new kernel, though.

