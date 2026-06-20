Return-Path: <netdev+bounces-300776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id miLLGw8HNmr26wYAu9opvQ
	(envelope-from <netdev+bounces-300776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 05:20:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ED25A6A841C
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 05:20:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Xfmq/JWu";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300776-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300776-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 423CD3009177
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 03:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EB01F1932;
	Sat, 20 Jun 2026 03:20:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66801202F70
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 03:20:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781925644; cv=none; b=fDEZLXBduolNUHTxBogE47Y7gUZ1NaiVwaxg2j2T2BcjVwxGS7RX/MjLP0pq9/hTlJcS5OSb1mw4+fFbVVbR+FDgnuFA4+F1gsCCLYw5X66AQ9qKkcuo7Airq1teyc+fBmjw+ZW+BEqzgxFmSg3N99V46Sbncqst7B1C267Gv6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781925644; c=relaxed/simple;
	bh=BBwuWlfyu6CpmJmaqQ7OqRxdrmBAG4TceRywkJvwz4g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jOf4Wh0ouaFCbtHOb7Cdi4QJxhJGr7rUW6OodilLDtM1eIC3HuZnGI2bVBfQfylW4uNBpb9gJRSznCMeaSxWcqdO+MluGgHzenXoLLrbxvxHHUoHwuGzi5qppT0s/ke/qprXcpwJ0ocLKYd/504cLoKvsKhTiNnqJFM5aLrngeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xfmq/JWu; arc=none smtp.client-ip=209.85.160.53
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-440f9c48b85so2280097fac.1
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 20:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781925642; x=1782530442; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gQJghkrz5Uwqrbb7kMScA7hnholHzLSlGz8SYwIGNg=;
        b=Xfmq/JWu8RgMml2H+X96O7Wra0CrJfKC2VMDzA9CaPrw3nVnIXVSaxIICXMEskZ0Xz
         FPh88uISvkVkc6jYlrXx+otqiBeLiDoUq727DepPulBk15I8UuwnGTcpzlGvaRdYCgst
         6WPR7TUT85mlBtli8ZnhNVyoKmSnA8QaQaLl/rcjShvbWI6V0nM39/8OqvfWMM9uDQaa
         uEffoUrSll4tBL8Ec/mIuyU3feM44SGJreTzNFRP2cdb9i2IH6ZX47YeV9XAbvfyKfiy
         MhVFVl3hEQ2i48WC4F1gway6jHVCG4a6gLmZCo8D5B+qtCymlGf5zEMYK9qrUkG9taek
         jNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781925642; x=1782530442;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+gQJghkrz5Uwqrbb7kMScA7hnholHzLSlGz8SYwIGNg=;
        b=Y/7QYKYdlb+CgiHrgw072b90ayipN9EcY6A/7dPSFbdNrdCrVsl1w/ri7hK3KVzxVL
         QLujR6Y5z4ahEq8N2L/73pfEipCmTd1itrh5qRil5vhab39V3BQhXRPSmu8U2qgeE2Iu
         Sbc5SUj2utUuKKlvbK/QdsLZwmy2ioprLjpPRQ39VyQ3n1sUzzLb1Wtv+SDM3s6Sjix0
         09/YhiIvjc+n15sBQEIwJzh2Bz7Ms2WsoGk+Qi+Cjjer6IL9BuSNeNXj9O+KBYMwKfi+
         jRLQVrzFJRm1okzln3EdknDav7g2J6NNj21HYvs8hpBlo9U3mx91vqPmc3nEXk32FmUe
         pB1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+jQh4TSKtoY3dby+kxHl+oWLpzmHizJpqgpg2LZED41zJlQNZ8p1oZ8QkRATnK9m6Cq7Gg8m8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoi+h0q61CP+WYqPdbSIYP1B7c6Az226m2vK1Ntdc6Fjcwtg/r
	zViqh/w2Of2YOs75HV3KXVnsJnBGT81aZgn4zqdBE2eJL6aPQz62PnMz
X-Gm-Gg: AfdE7cm0b+ze+TZ0R0q96I6JhrQ+331GjvP0pvInH+g7yh8h89WCgzAxGBEicDdXgW0
	TlKgNlFCIaoXyavQ5khCuDO3zSb0ODUAnJxy1L7XUbULAVzgzjPu5YtUCp/WlKT5DpafBNXE9EG
	MDTQa7Jz6hQsfhYA3D/fZM+/UtELR58OI40/Ty9Yj8oGBIVVZxGEkZuAzRIXejc4VkmlB7Qrsl1
	+BWm2SmOYxzoB/ZiAm9hdwSEWXaD5/pB134+WblJX7Z5PzhKq3096waudTDbodBVmPCEeG2DOMc
	5en65NZbiaga+xtx7NwzX8ZTXU2MXJpb9tzw+d4svjd7snTy1//9lgcZP1yDaC/+QgvZ8KYEC10
	sKMtMEY+SFA3Imx4WODhXp7+P/xZhROEeVBomz+CXHQTHBOGxujIkkZdwzLlLyzNJEELs4U1Lfm
	8JAjv4ggrZfGTf9lc7nxybZAc69JjjKC7E3x2e/GXGq6l6fiDw2ZHkLzPtcqGKenlbzRbaL9HHt
	0Liylk=
X-Received: by 2002:a05:6870:ac86:b0:439:b99e:4414 with SMTP id 586e51a60fabf-4470a6fa4famr3750999fac.6.1781925642205;
        Fri, 19 Jun 2026 20:20:42 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:58::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472f04236fsm1099930fac.14.2026.06.19.20.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 20:20:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jun 2026 20:20:40 -0700
Message-Id: <DJDJX62AS415.2BVILN08QK149@gmail.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Simon Horman" <horms@kernel.org>, "Kuniyuki Iwashima" <kuniyu@google.com>,
 "Willem de Bruijn" <willemb@google.com>, <linux-fsdevel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>
Subject: Re: [PATCH 1/2] fs: Add bpf_sock_read_xattr() kfunc to read socket
 xattrs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Christian Brauner" <brauner@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>
X-Mailer: aerc
References: <20260617-work-bpf-sock-xattr-v1-0-a1276f7c9da3@kernel.org>
 <20260617-work-bpf-sock-xattr-v1-1-a1276f7c9da3@kernel.org>
In-Reply-To: <20260617-work-bpf-sock-xattr-v1-1-a1276f7c9da3@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.65 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300776-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:horms@kernel.org,m:kuniyu@google.com,m:willemb@google.com,m:linux-fsdevel@vger.kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:brauner@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,suse.cz,kernel.org,google.com,vger.kernel.org,linux.dev,gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED25A6A841C

On Wed Jun 17, 2026 at 4:18 AM PDT, Christian Brauner wrote:
> In c8db08110cbe ("Merge tag 'vfs-7.1-rc1.xattr' of git://git.kernel.org/p=
ub/scm/linux/kernel/git/vfs/vfs")
> we added support for extended attributes for sockets. This comes in two
> flavors: sockfs and non-sockfs/filesystem sockets. Filesystem sockets
> are actual filesystem objects so reading xattrs must use dedicated fs
> helpers such as bpf_get_dentry_xattr() and bpf_get_file_xattr(). Those
> are inherently sleeping operations. Sockfs sockets on the other hand
> don't need to use sleeping operations as the underlying data structure
> is lockless. In addition, retrieval of sockfs extended attributes often
> happens from LSM hooks that only provide struct socket and it's
> completely nonsensical to grab a reference to a file, then force a
> sleeping operation to retrieve the xattr and drop the reference. We know
> that the sockfs file cannot go away while the LSM hook runs.
>
> This series adds a bpf_sock_read_xattr() kfunc that, given a struct
> socket, reads a user.* extended attribute from the socket's sockfs inode
> into a bpf_dynptr. Together with fsetxattr() from userspace this lets a
> process label a socket with a user.* xattr and have a BPF LSM program
> retrieve that label locklessly. The kfunc mirrors the existing
> bpf_cgroup_read_xattr(), including the restriction to the user.*
> namespace.
>
> systemd uses user.* xattrs on sockets to implement socket rate limiting
> and to tag sockets for other purposes [1] such as implementing a varlink
> registry. There is currently no efficient way for a BPF program to read
> those labels back. The new helper allows a listening socket marked with
> an extended attribute to be read back during bind/connect and then act
> on the connect()ing socket. Extended attributes make it possible to
> allow an unprivileged user manager such as systemd --user to mark
> sockets from userspace and then rediscover them or implement policies.
>
> The kfunc is registered KF_RCU and only for BPF LSM programs. A struct
> socket is only guaranteed to live in sockfs when an LSM socket hook hands
> it out, which is what keeps SOCK_INODE() valid. Sockets that embed struct
> socket outside sockfs (tun, tap) are only reachable from tracing programs
> and are excluded by the registration. (Btw, for consistency it would
> be nice to force allocation of struct socket from sockfs instead of
> simply embedding it in e.g., struct tun_file which makes the SOCKFS_I()
> pattern a hazard - at least outside of sockfs functions.)
>
> The read never sleeps and takes no lock. For sockfs the value lives in
> the inode's in-memory xattr store and simple_xattr_get() resolves it
> with an RCU-protected rhashtable lookup, taking neither the inode lock
> nor any xattr lock. The kfunc is therefore usable from both sleepable
> and non-sleepable LSM hooks.
>
> Link: https://github.com/systemd/systemd/pull/40559 [1]
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/bpf_fs_kfuncs.c  | 37 +++++++++++++++++++++++++++++++++++++
>  include/linux/net.h |  1 +
>  net/socket.c        | 25 +++++++++++++++++++++++++
>  3 files changed, 63 insertions(+)
>
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 11841c3d4260..85fc9519d1ff 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -11,6 +11,7 @@
>  #include <linux/file.h>
>  #include <linux/kernfs.h>
>  #include <linux/mm.h>
> +#include <linux/net.h>
>  #include <linux/xattr.h>
> =20
>  __bpf_kfunc_start_defs();
> @@ -359,6 +360,39 @@ __bpf_kfunc int bpf_cgroup_read_xattr(struct cgroup =
*cgroup, const char *name__s
>  }
>  #endif /* CONFIG_CGROUPS */
> =20
> +#ifdef CONFIG_NET
> +/**
> + * bpf_sock_read_xattr - read xattr of a socket's inode in sockfs
> + * @sock: socket to get xattr from
> + * @name__str: name of the xattr
> + * @value_p: output buffer of the xattr value
> + *
> + * Get xattr *name__str* of *sock* and store the output in *value_p*.
> + *
> + * For security reasons, only *name__str* with prefix "user." is allowed=
.
> + *
> + * Return: length of the xattr value on success, a negative value on err=
or.
> + */
> +__bpf_kfunc int bpf_sock_read_xattr(struct socket *sock, const char *nam=
e__str,
> +				    struct bpf_dynptr *value_p)
> +{
> +	struct bpf_dynptr_kern *value_ptr =3D (struct bpf_dynptr_kern *)value_p=
;
> +	u32 value_len;
> +	void *value;
> +
> +	/* Only allow reading "user.*" xattrs */
> +	if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
> +		return -EPERM;
> +
> +	value_len =3D __bpf_dynptr_size(value_ptr);
> +	value =3D __bpf_dynptr_data_rw(value_ptr, value_len);
> +	if (!value)
> +		return -EINVAL;
> +
> +	return sock_read_xattr(sock, name__str, value, value_len);
> +}
> +#endif /* CONFIG_NET */

lgtm.
How do you want to route it? Thought vfs tree for the next merge window?
If so
Acked-by: Alexei Starovoitov <ast@kernel.org>

