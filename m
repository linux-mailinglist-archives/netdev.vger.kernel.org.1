Return-Path: <netdev+bounces-178353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3305A76B83
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 18:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652E23A3CBB
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 15:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD3221147A;
	Mon, 31 Mar 2025 15:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crOCirZT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D05C21322E
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743436475; cv=none; b=TwCPYrvsFcI5V0WIvBI1H+coWjh3QsfGUd1fFGb38RmMPkKTZRfcif/mTOQLrpBGpaJcpfoW24b5F1up+L/FZN/V8FOlZEzFvlLUaybfGPwTURY1TrD2amohEIoM+nzx55YaARJ7OZO2LeaaplVFcwvoPy8U0OKCN+9SA1AYBeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743436475; c=relaxed/simple;
	bh=vYO9oSFhie6+KI9zPlYco/1gwglKnBtR6c+jnB3jXWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/ibjm0VjpNqSHMk2jdb3Ui4Sfn2PRXEcJvfZAqzqFN6qD8Y0L7dqGUuL1R8DdG0o5spwevYH9cFFP2s9O4HVET4HE2fhMQo9PpIM/AHL3pJGXg5NefuJgMhrOkanO30f3nv5VbNGE50gxrPHSFmK3rebjkykYxC7ry84u2OviI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crOCirZT; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-85dac9729c3so325733439f.2
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 08:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743436473; x=1744041273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rgd3Ift2LNhbneGCk0ghF9LMp1fKeCmesiuDQnV3OQk=;
        b=crOCirZT17NSJf6YAAbGTE3r9TMYWNf9phy4o6l6b5viXiSAB8rkeJTuVG8gdDQ+3W
         KVUiuTZJF1Y/omnv5W3UJREpI1PYBBNyyQqdJP7dIqPp2heATQarEkijx3N/k6oSSMRN
         xK/gXt5DXgaa5SDRK9Enu5UxQKnKxlwdm5Zlszl5qxCv6tovnJyiUTCZ6hqNR41H654d
         ugwo3NJLdPxmpJJeleUdvg7NMwjb78XG2LINXsOf9wBAHCOg2ffMtiAvrJ4lsg3Cwkui
         uK0NoIxZ3u966IwfVPD4EHgpn182xDxrQoYr26CR0X3uPQ//6H8Gtw/m49lifwu9Vj32
         9FfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743436473; x=1744041273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rgd3Ift2LNhbneGCk0ghF9LMp1fKeCmesiuDQnV3OQk=;
        b=B4/tXx3JZFpDPC8DttSDP37IZTcjFDPFSdtzTzPa1l3GkQrOwZO1bL5olvSJA3fvJx
         PvoYouM8T8PV2O1lxVcKze/quY/RzANwSHAwic8YEF/k1boWwQ/MMdiwezpb32s8DS0v
         uELKaUzHAaLkSIkE4qBdgaDBYMvIzoQ0wT40W5iRkbV30Yi2u4qg201+jVhni3VAf4Oa
         c5WPsrbR/ITUXya8gnwnSKMgDfhK8e4Tqi/4/qTAFOr80qEA2UYJAQV08Ol1HY6oa5Ex
         1gvAlcK1dHtEC2m6sUrvy/mlRZvYND18v1h73EWYI91ZJ53Nx5Z7dNpgF83I1sM9cmId
         76Iw==
X-Forwarded-Encrypted: i=1; AJvYcCX3tef8BWfHWwDYVZIgUvzCNdlCykmPfLmfLb9zxZNeqfXvuFFjur2c9HhzccY8lNeEnsxIyeI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/JOIHbotKWfzQ2lTQLRmVbInCJnrHQdv9E+hfQM4/kvH5eHbS
	AIao/s1gfFAEQEnSKjYLsH8NDFeyPiYGamLsNnj1iH1oy2x0z7Fz8df0cK2pSogjL0YAGqYXGEY
	9X2BYgM2htF9OvrrmlP83tf8b0UU=
X-Gm-Gg: ASbGncsxrgDYwMAs1voh1pXstprQR295VTo1vZJK9PTeVrwE2h09WB06ZVKi+4I8a9g
	LtAUg8YLLpAp4J7EpaEIK04DGSA8WrvozzjXgATSVhOvh9ioVIYxTFWprmZp0XHgdB5+nJXk7fl
	88PAwpbBuE1XFLJ8vEzhuK4tRK2g1jUSV8Hb0rnnj5sAqFQleFbKxAMI7AUj0Vah8Su40t0Q==
X-Google-Smtp-Source: AGHT+IGEkJnipXau6/nGFtME2bQfhEv4Kf0nAmEKhCC2Qq00rs3tif7f/YOcmx8X8dqGwN23OvyN2UXoY2vlNatudY0=
X-Received: by 2002:a05:6e02:194e:b0:3cf:fe21:af8 with SMTP id
 e9e14a558f8ab-3d5e08ed0afmr101171965ab.4.1743436473003; Mon, 31 Mar 2025
 08:54:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331091532.224982-1-edumazet@google.com>
In-Reply-To: <20250331091532.224982-1-edumazet@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 31 Mar 2025 11:54:21 -0400
X-Gm-Features: AQ5f1JpwzpTUZJ24QC11ozOxbBg0Pv2rMyQs9HpizyNaQetKUD5xJnKup2ROHE0
Message-ID: <CADvbK_eneePox-VFbicSmt55g+VJdc+5m_LoS2bu_Pezatjq0g@mail.gmail.com>
Subject: Re: [PATCH net] sctp: add mutual exclusion in proc_sctp_do_udp_port()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+fae49d997eb56fa7c74d@syzkaller.appspotmail.com, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 5:15=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> We must serialize calls to sctp_udp_sock_stop() and sctp_udp_sock_start()
> or risk a crash as syzbot reported:
>
> Oops: general protection fault, probably for non-canonical address 0xdfff=
fc000000000d: 0000 [#1] SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000068-0x000000000000006f]
> CPU: 1 UID: 0 PID: 6551 Comm: syz.1.44 Not tainted 6.14.0-syzkaller-g7f2f=
f7b62617 #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 02/12/2025
>  RIP: 0010:kernel_sock_shutdown+0x47/0x70 net/socket.c:3653
> Call Trace:
>  <TASK>
>   udp_tunnel_sock_release+0x68/0x80 net/ipv4/udp_tunnel_core.c:181
>   sctp_udp_sock_stop+0x71/0x160 net/sctp/protocol.c:930
>   proc_sctp_do_udp_port+0x264/0x450 net/sctp/sysctl.c:553
>   proc_sys_call_handler+0x3d0/0x5b0 fs/proc/proc_sysctl.c:601
>   iter_file_splice_write+0x91c/0x1150 fs/splice.c:738
>   do_splice_from fs/splice.c:935 [inline]
>   direct_splice_actor+0x18f/0x6c0 fs/splice.c:1158
>   splice_direct_to_actor+0x342/0xa30 fs/splice.c:1102
>   do_splice_direct_actor fs/splice.c:1201 [inline]
>   do_splice_direct+0x174/0x240 fs/splice.c:1227
>   do_sendfile+0xafd/0xe50 fs/read_write.c:1368
>   __do_sys_sendfile64 fs/read_write.c:1429 [inline]
>   __se_sys_sendfile64 fs/read_write.c:1415 [inline]
>   __x64_sys_sendfile64+0x1d8/0x220 fs/read_write.c:1415
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>
> Fixes: 046c052b475e ("sctp: enable udp tunneling socks")
> Reported-by: syzbot+fae49d997eb56fa7c74d@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/67ea5c01.050a0220.1547ec.012b.GAE@=
google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> Cc: Xin Long <lucien.xin@gmail.com>
> ---
>  net/sctp/sysctl.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
> index 8e1e97be4df79f3245e2bbbeb0a75841abc67f58..ee3eac338a9deef064f273e29=
bb59b057835d3f1 100644
> --- a/net/sctp/sysctl.c
> +++ b/net/sctp/sysctl.c
> @@ -525,6 +525,8 @@ static int proc_sctp_do_auth(const struct ctl_table *=
ctl, int write,
>         return ret;
>  }
>
> +static DEFINE_MUTEX(sctp_sysctl_mutex);
> +
>  static int proc_sctp_do_udp_port(const struct ctl_table *ctl, int write,
>                                  void *buffer, size_t *lenp, loff_t *ppos=
)
>  {
> @@ -549,6 +551,7 @@ static int proc_sctp_do_udp_port(const struct ctl_tab=
le *ctl, int write,
>                 if (new_value > max || new_value < min)
>                         return -EINVAL;
>
> +               mutex_lock(&sctp_sysctl_mutex);
>                 net->sctp.udp_port =3D new_value;
>                 sctp_udp_sock_stop(net);
>                 if (new_value) {
> @@ -561,6 +564,7 @@ static int proc_sctp_do_udp_port(const struct ctl_tab=
le *ctl, int write,
>                 lock_sock(sk);
>                 sctp_sk(sk)->udp_port =3D htons(net->sctp.udp_port);
>                 release_sock(sk);
> +               mutex_unlock(&sctp_sysctl_mutex);
>         }
>
>         return ret;
> --
> 2.49.0.472.ge94155a9ec-goog
>
Instead of introducing a new lock for this, wouldn't be better to just
move up `lock_sock(sk)` a little bit?

