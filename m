Return-Path: <netdev+bounces-252183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMxaAqqhcWmgKQAAu9opvQ
	(envelope-from <netdev+bounces-252183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:03:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C7D61931
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CCF1350119F
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0427E428495;
	Thu, 22 Jan 2026 03:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tnbk32EV"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757B53EFD01;
	Thu, 22 Jan 2026 03:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769054221; cv=none; b=TmMtzj8LfIpA34PLih36jPnVede+R99cpywJoaM7R5Wgczz3dbriGbQUdaEqDVzvT5u87wpwQ6rx3uoCnz+ha77Tr9DDbcroSb4PANYqOk/miigXZDVzvUMoF7S4A0awr3Xei3Lwv5RFUko/EwobcmN7HEws9BtAMim/HPsOPW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769054221; c=relaxed/simple;
	bh=8CWbKn4B3otnb2aE9paHyXfek7EjnLT6DPAgKtM13bs=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=HDaUft3F41tnj9clKmtD4HhsVjQ95QjGh02gSX0BJVBZBZu/mqR6yTggw+B67mfTFRKSj4Xc4JhlZ/xttbZVAdQkQquRce8tGjbZpbrwkfPGY7AH9PG8BrJ735+JZHK6iZwYvcQsx4o6B0hX/Nh3dP+AW4yMPJno4/jsOZXrO2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tnbk32EV; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769054215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJjNbDiEoaEZiK5zl5dzy3/Rfr7vKO+iFtl3X79v/h0=;
	b=tnbk32EVCvZcyQYvNPrutqCjjG6Pq+3mHxGetf+LgeZGpDgZtJKz9UFRvotC3hOl6Gmj00
	L/tkh6d/Ft8ZIo2rowBAI/kkCZXjEml0x/evjBjEiPPIav9zDlKTsKKqfcpYGF4V511b3h
	qmppEpycDdcQtZof4Tw+1SPtPIH3PdY=
Date: Thu, 22 Jan 2026 03:56:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <d8c440c1255979b5120eed985f7d156f68cd7a3f@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v7 2/3] bpf, sockmap: Fix FIONREAD for sockmap
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, "John Fastabend" <john.fastabend@gmail.com>, "David 
  S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Neal Cardwell"
 <ncardwell@google.com>, "Kuniyuki Iwashima" <kuniyu@google.com>, "David 
 Ahern" <dsahern@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel  Borkmann" <daniel@iogearbox.net>, "Martin 
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "KP  Singh"
 <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao  Luo"
 <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, "Michal Luczaj" <mhal@rbox.co>, "Cong Wang"
 <cong.wang@bytedance.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
In-Reply-To: <60a0c463ef6dbe38d836c773c5256706c163311c@linux.dev>
References: <20260113025121.197535-1-jiayuan.chen@linux.dev>
 <20260113025121.197535-3-jiayuan.chen@linux.dev>
 <87a4y8uy67.fsf@cloudflare.com> <871pjjux2u.fsf@cloudflare.com>
 <60a0c463ef6dbe38d836c773c5256706c163311c@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,fomichev.me,rbox.co,bytedance.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252183-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	DKIM_TRACE(0.00)[linux.dev:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B0C7D61931
X-Rspamd-Action: no action

January 21, 2026 at 20:55, "Jiayuan Chen" <jiayuan.chen@linux.dev mailto:=
jiayuan.chen@linux.dev?to=3D%22Jiayuan%20Chen%22%20%3Cjiayuan.chen%40linu=
x.dev%3E > wrote:


>=20
>=20January 21, 2026 at 17:36, "Jakub Sitnicki" <jakub@cloudflare.com mai=
lto:jakub@cloudflare.com?to=3D%22Jakub%20Sitnicki%22%20%3Cjakub%40cloudfl=
are.com%3E > wrote:
>=20
>=20>=20
>=20> On Tue, Jan 20, 2026 at 04:00 PM +01, Jakub Sitnicki wrote:
> >=20=20
>=20>=20=20
>=20>  On Tue, Jan 13, 2026 at 10:50 AM +08, Jiayuan Chen wrote:
> >=20=20
>=20>  [...]
> >=20=20
>=20>=20=20
>=20>  >=20
>=20>  > diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
> >  > index 0735d820e413..91233e37cd97 100644
> >  > --- a/net/ipv4/udp_bpf.c
> >  > +++ b/net/ipv4/udp_bpf.c
> >  > @@ -5,6 +5,7 @@
> >  > #include <net/sock.h>
> >  > #include <net/udp.h>
> >  > #include <net/inet_common.h>
> >  > +#include <asm/ioctls.h>
> >  >=20
>=20>  > #include "udp_impl.h"
> >  >=20
>=20>  > @@ -111,12 +112,26 @@ enum {
> >  > static DEFINE_SPINLOCK(udpv6_prot_lock);
> >  > static struct proto udp_bpf_prots[UDP_BPF_NUM_PROTS];
> >  >=20
>=20>  > +static int udp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
> >  > +{
> >  > + if (cmd !=3D SIOCINQ)
> >  > + return udp_ioctl(sk, cmd, karg);
> >  > +
> >  > + /* Since we don't hold a lock, sk_receive_queue may contain data=
.
> >  > + * BPF might only be processing this data at the moment. We only
> >  > + * care about the data in the ingress_msg here.
> >  > + */
> >  >=20
>=20>  I think we should strive for a design where FIONREAD does not go d=
own
> >  after you add your socket to sockmap, if there was no recvmsg call i=
n
> >  between. To show what I mean, I added this test that's currently fai=
ling
> >  for udp:
> >=20=20
>=20>  ---8<---
> >  diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c =
b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> >  index 1f1289f5a8c2..123c96fcaef0 100644
> >  --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> >  +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> >  @@ -1229,6 +1229,66 @@ static void test_sockmap_copied_seq(bool strp=
)
> >  test_sockmap_pass_prog__destroy(skel);
> >  }
> >=20=20
>=20>  +/* Test FIONREAD when data exists in sk_receive_queue before sock=
map insertion */
> >  +static void test_sockmap_fionread_pre_insert(int sotype)
> >  +{
> >  + int map, err, sent, recvd, zero =3D 0, avail =3D 0;
> >  + struct test_sockmap_pass_prog *skel =3D NULL;
> >  + int c =3D -1, p =3D -1;
> >  + char buf[10] =3D "0123456789", rcv[11];
> >  + struct bpf_program *prog;
> >  +
> >  + skel =3D test_sockmap_pass_prog__open_and_load();
> >  + if (!ASSERT_OK_PTR(skel, "open_and_load"))
> >  + return;
> >  +
> >  + prog =3D skel->progs.prog_skb_verdict;
> >  + map =3D bpf_map__fd(skel->maps.sock_map_rx);
> >  +
> >  + err =3D bpf_prog_attach(bpf_program__fd(prog), map, BPF_SK_SKB_STR=
EAM_VERDICT, 0);
> >  + if (!ASSERT_OK(err, "bpf_prog_attach verdict"))
> >  + goto end;
> >  +
> >  + err =3D create_pair(AF_INET, sotype, &c, &p);
> >  + if (!ASSERT_OK(err, "create_pair"))
> >  + goto end;
> >  +
> >  + /* Step 1: Send data BEFORE sockmap insertion - lands in sk_receiv=
e_queue */
> >  + sent =3D xsend(p, buf, sizeof(buf), 0);
> >  + if (!ASSERT_EQ(sent, sizeof(buf), "xsend pre-insert"))
> >  + goto end;
> >  +
> >  + /* Step 2: Verify FIONREAD reports data in sk_receive_queue */
> >  + err =3D poll_read(c, IO_TIMEOUT_SEC);
> >  + if (!ASSERT_OK(err, "poll_read pre-insert"))
> >  + goto end;
> >  + err =3D ioctl(c, FIONREAD, &avail);
> >  + ASSERT_OK(err, "ioctl(FIONREAD) pre-insert error");
> >  + ASSERT_EQ(avail, sizeof(buf), "ioctl(FIONREAD) pre-insert");
> >  +
> >  + /* Step 3: Insert socket into sockmap */
> >  + err =3D bpf_map_update_elem(map, &zero, &c, BPF_ANY);
> >  + if (!ASSERT_OK(err, "bpf_map_update_elem(c)"))
> >  + goto end;
> >  +
> >  + /* Step 4: FIONREAD should still report the data in sk_receive_que=
ue */
> >  + err =3D ioctl(c, FIONREAD, &avail);
> >  + ASSERT_OK(err, "ioctl(FIONREAD) post-insert error");
> >  + ASSERT_EQ(avail, sizeof(buf), "ioctl(FIONREAD) post-insert");
> >  +
> >  + /* Verify we can still read the data */
> >  + recvd =3D recv_timeout(c, rcv, sizeof(rcv), MSG_DONTWAIT, IO_TIMEO=
UT_SEC);
> >  + ASSERT_EQ(recvd, sizeof(buf), "recv post-insert");
> >  + ASSERT_OK(memcmp(buf, rcv, recvd), "data mismatch");
> >  +
> >  +end:
> >  + if (c >=3D 0)
> >  + close(c);
> >  + if (p >=3D 0)
> >  + close(p);
> >  + test_sockmap_pass_prog__destroy(skel);
> >  +}
> >  +
> >  /* it is used to send data to via native stack and BPF redirecting *=
/
> >  static void test_sockmap_multi_channels(int sotype)
> >  {
> >  @@ -1373,4 +1433,8 @@ void test_sockmap_basic(void)
> >  test_sockmap_multi_channels(SOCK_STREAM);
> >  if (test__start_subtest("sockmap udp multi channels"))
> >  test_sockmap_multi_channels(SOCK_DGRAM);
> >  + if (test__start_subtest("sockmap tcp fionread pre-insert"))
> >  + test_sockmap_fionread_pre_insert(SOCK_STREAM);
> >  + if (test__start_subtest("sockmap udp fionread pre-insert"))
> >  + test_sockmap_fionread_pre_insert(SOCK_DGRAM);
> >  }
> >  --->8---
> >=20=20
>=20>  >=20
>=20>  > + *karg =3D sk_msg_first_len(sk);
> >  > + return 0;
> >  > +}
> >  > +
> >  >
> >=20=20
>=20>  I've been thinking about this some more and came to the conclusion=
 that
> >  this udp_bpf_ioctl implementation is actually what we want, while
> >  tcp_bpf_ioctl *should not* be checking if the sk_receive_queue is
> >  non-empty.
> >=20=20
>=20>  Why? Because the verdict prog might redirect or drop the skbs from
> >  sk_receive_queue once it actually runs. The messages might never app=
ear
> >  on the msg_ingress queue.
> >=20=20
>=20>  What I think we should be doing, in the end, is kicking the
> >  sk_receive_queue processing on bpf_map_update_elem, if there's data
> >  ready.
> >=20=20
>=20>  The API semantics I'm proposing is:
> >=20=20
>=20>  1. ioctl(FIONREAD) -> reports N bytes
> >  2. bpf_map_update_elem(sk) -> socket inserted into sockmap
> >  3. poll() for POLLIN -> wait for socket to be ready to read
> >  5. ioctl(FIONREAD) -> report N bytes if verdict prog didn't
> >  redirect or drop it
> >=20=20
>=20>  We don't have to add the the queue kick on map update in this seri=
es.
> >=20=20
>=20>  If you decide to leave it for later, can I ask that you open an is=
sue at
> >  our GH project [1]?
> >=20=20
>=20>  I don't want it to fall through the cracks. And I sometimes have p=
eople
> >  asking what they could help with in sockmap.
> >=20=20
>=20>  Thanks,
> >  -jkbs
> >=20=20
>=20>  [1] https://github.com/sockmap-project/sockmap-project/issues
> >=20
>=20Hi Jakub,
>=20
>=20Thanks for taking the time to think through this carefully. I agree w=
ith your
> analysis - reporting sk_receive_queue length is misleading since the ve=
rdict
> prog might redirect or drop those skbs.
>=20
>=20There's no rush to merge this patch.
>=20
>=20Since the kick queue on bpf_map_update_elem addresses a closely relat=
ed issue,
> I think it makes sense to include it in this patchset for easier tracki=
ng rather
> than splitting it out.
>=20
>=20I'll spend more time looking into this and come back with an updated =
version.
>=20
>=20Thanks,
> Jiayuan
>


Hi Jakub,

  I've been thinking about this more, and I realize the problem is not as=
 simple as it seems.

  Regarding kicking the sk_receive_queue on bpf_map_update_elem: the BPF
  program may not be fully initialized at that point. For example, with a
  redirect program, the destination fd might not yet be inserted into the
  map. If we kick the data through the BPF program immediately, the
  redirect lookup would fail, leading to unexpected behavior (data being
  dropped or passed to the wrong socket).

  I also considered triggering the kick in poll/select via
  sk_msg_is_readable(). However, this approach doesn't work for TCP
  because tcp_poll() -> tcp_stream_is_readable() -> tcp_epollin_ready()
  will return early when sk_receive_queue has data, before ever calling
  sk_is_readable().

  In the next version, I'll address your other nits and remove the
  sk_receive_queue check from tcp_bpf_ioctl. I'll also open an issue on
  the GH project to track this problem so we can continue exploring
  better solutions.

  Thanks,
  Jiayuan

