Return-Path: <netdev+bounces-124197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFA1968762
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60B801F207C7
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 12:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F2619E96F;
	Mon,  2 Sep 2024 12:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7OmQO8u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7AC19E96A
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725279643; cv=none; b=J0VJBRMbO26DC3G7b9c5wT3wFoRpGPArbSLo0jxs0hW6mM6bK4g+keiT5dm34DzD+Bw0jneh7A4kBW3aUmQ45Xbr8960WtxfXNbneeVzOr3vL438iOk3J/2AUTWGQn3m+LfKFnTpzFIwrHfgTjREKjDp3QhnejwgzzzcP+aEjhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725279643; c=relaxed/simple;
	bh=vYHvIN20pIuBhh8QIOpdRq3+0ZLWrEwcYhUKni0oLF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JV9sOAq/b8PWVeIZ7hyE/9vwFYB8lGrAN/Z1vYcM3/E9LtqN+ZkxQ20YkgIag/kWMzxa557x6VAd5Dgt85SRUioXQVhfUYBRuY5GtdTshdGZ5MeAd5wUHCsFOnxKThnEpKfEL+F8p3EjHXRkWFT2x3D6RSMDfE5Rj+lqEMGleQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7OmQO8u; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-39e6b1ab200so16110415ab.0
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 05:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725279640; x=1725884440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1egdupOtaU8weNkytLHdeIfSASJaZdFYGZCHymCduE=;
        b=h7OmQO8uBlDd/VKueOXSchRkjBfhQEg/JRCvKac6QvcfeKSweGTbBn+xGM26zvQERg
         xkUoRFbY/Sf3luamy1krbXlFcG72NO6IKD11I6yn3akOhkeX+X0rh4sFlx1lU9uM8WsN
         M38NV7VxWkIgloNms6uFRLJqGOBduLTr2eCqvQBi4B83WppNizzeiLqFkIaQ5njadNjR
         2R4Cf0zRj+v4LDeM98sZ578kRTrCUC5OETDlYP9y1UxdQVKM/YrO3MGyrIyrPLjxAUJ4
         9tS+dYWDEeV4XXJO9ULzuqc5QSEfc4jy92K7Oo1SIBR0tsTgLy+Cbh+CPOMjzpYp9fwG
         TwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725279640; x=1725884440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1egdupOtaU8weNkytLHdeIfSASJaZdFYGZCHymCduE=;
        b=Ub5DToAQeXud+wkpYKAwEwMORFTDgiFZp6BGKkudyeG/r4ECaXWtCuHIyCqAymbutr
         kNWAPweFHe8i1LWgX9fM6/350PjoKUv+k8mrZIcfTWzB2UUpbYtL5IFbaB4hTbNdsw0B
         NOZ2zaoZ66pMokKwfjD/W4CUinv01nYki/K4GJw3Jl9lzXEJOoUgXz73GjNkvr51tYi/
         Te30iv1ypYmxf+QgXboi4UyzRfrKeSsXl8TTnagz78M2H/M/VQeqiKgHxqtXZwFq9F/v
         tajK6GtJX67Zs5+NceA/QOJzWa7Vc7ef2CAoI8mnsxNJksnvqFsXP2rOF62bM5QSYfRL
         cU3w==
X-Forwarded-Encrypted: i=1; AJvYcCUl+Te4DWN/2pfQb+8KQCP7K4JXcZ1pcyUaMqMfkmX+t8ptZXLGC+jxhL79Vg4o3aKKux3EYak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxICiWEtADNa+0RVggXV2wSzaRtMHd3+ikgDzl3qaaGn3KBFPca
	VikBgCbd5jjQMct+5VzNLPcNsjklJGRJeKfMlcfSJBOfS2DsyDj21v353CuZ/r6yQem72M2r5AI
	mKlzGvMGbmxN2NqV+PRg4PqSiMvs=
X-Google-Smtp-Source: AGHT+IE09xiDEHnsq+2OQJHkZSNLuVXgkEQrgEEJz9Pec9jmlkino3zY+Tlr+XtNnZfBgkIJaM7098is026w7wOChPU=
X-Received: by 2002:a05:6e02:154b:b0:398:36c0:7968 with SMTP id
 e9e14a558f8ab-39f4f681e98mr77305735ab.6.1725279639974; Mon, 02 Sep 2024
 05:20:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829204922.1674865-1-vadfed@meta.com> <20240829204922.1674865-2-vadfed@meta.com>
 <CAL+tcoCeQ5R9Pp=__hi6xuQzACj9v1+TQarMky8c2nzcBN0+Xg@mail.gmail.com> <5d8b523d-ca30-40d7-bc08-f7959de47e4b@linux.dev>
In-Reply-To: <5d8b523d-ca30-40d7-bc08-f7959de47e4b@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 2 Sep 2024 20:20:03 +0800
Message-ID: <CAL+tcoChfxje3wNxL2gpvro3y04DPY5YRpdUWBVYx7ixObakPw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] selftests: txtimestamp: add SCM_TS_OPT_ID test
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 5:12=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 02/09/2024 02:29, Jason Xing wrote:
> > Hello Vadim,
> >
> > On Fri, Aug 30, 2024 at 4:55=E2=80=AFAM Vadim Fedorenko <vadfed@meta.co=
m> wrote:
> >>
> >> Extend txtimestamp udp test to run with fixed tskey using
> >> SCM_TS_OPT_ID control message.
> >>
> >> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> >> ---
> >>   tools/include/uapi/asm-generic/socket.h    |  2 +
> >>   tools/testing/selftests/net/txtimestamp.c  | 48 +++++++++++++++++---=
--
> >>   tools/testing/selftests/net/txtimestamp.sh |  1 +
> >>   3 files changed, 41 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/tools/include/uapi/asm-generic/socket.h b/tools/include/u=
api/asm-generic/socket.h
> >> index 54d9c8bf7c55..281df9139d2b 100644
> >> --- a/tools/include/uapi/asm-generic/socket.h
> >> +++ b/tools/include/uapi/asm-generic/socket.h
> >> @@ -124,6 +124,8 @@
> >>   #define SO_PASSPIDFD           76
> >>   #define SO_PEERPIDFD           77
> >>
> >> +#define SCM_TS_OPT_ID          78
> >> +
> >>   #if !defined(__KERNEL__)
> >>
> >>   #if __BITS_PER_LONG =3D=3D 64 || (defined(__x86_64__) && defined(__I=
LP32__))
> >> diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testing=
/selftests/net/txtimestamp.c
> >> index ec60a16c9307..3a8f716e72ae 100644
> >> --- a/tools/testing/selftests/net/txtimestamp.c
> >> +++ b/tools/testing/selftests/net/txtimestamp.c
> >> @@ -54,6 +54,10 @@
> >>   #define USEC_PER_SEC   1000000L
> >>   #define NSEC_PER_SEC   1000000000LL
> >>
> >> +#ifndef SCM_TS_OPT_ID
> >> +# define SCM_TS_OPT_ID 78
> >> +#endif
> >> +
> >>   /* command line parameters */
> >>   static int cfg_proto =3D SOCK_STREAM;
> >>   static int cfg_ipproto =3D IPPROTO_TCP;
> >> @@ -77,6 +81,8 @@ static bool cfg_epollet;
> >>   static bool cfg_do_listen;
> >>   static uint16_t dest_port =3D 9000;
> >>   static bool cfg_print_nsec;
> >> +static uint32_t ts_opt_id;
> >> +static bool cfg_use_cmsg_opt_id;
> >>
> >>   static struct sockaddr_in daddr;
> >>   static struct sockaddr_in6 daddr6;
> >> @@ -136,12 +142,13 @@ static void validate_key(int tskey, int tstype)
> >>          /* compare key for each subsequent request
> >>           * must only test for one type, the first one requested
> >>           */
> >> -       if (saved_tskey =3D=3D -1)
> >> +       if (saved_tskey =3D=3D -1 || cfg_use_cmsg_opt_id)
> >>                  saved_tskey_type =3D tstype;
> >>          else if (saved_tskey_type !=3D tstype)
> >>                  return;
> >>
> >>          stepsize =3D cfg_proto =3D=3D SOCK_STREAM ? cfg_payload_len :=
 1;
> >> +       stepsize =3D cfg_use_cmsg_opt_id ? 0 : stepsize;
> >>          if (tskey !=3D saved_tskey + stepsize) {
> >>                  fprintf(stderr, "ERROR: key %d, expected %d\n",
> >>                                  tskey, saved_tskey + stepsize);
> >> @@ -480,7 +487,7 @@ static void fill_header_udp(void *p, bool is_ipv4)
> >>
> >>   static void do_test(int family, unsigned int report_opt)
> >>   {
> >> -       char control[CMSG_SPACE(sizeof(uint32_t))];
> >> +       char control[2 * CMSG_SPACE(sizeof(uint32_t))];
> >>          struct sockaddr_ll laddr;
> >>          unsigned int sock_opt;
> >>          struct cmsghdr *cmsg;
> >> @@ -620,18 +627,32 @@ static void do_test(int family, unsigned int rep=
ort_opt)
> >>                  msg.msg_iov =3D &iov;
> >>                  msg.msg_iovlen =3D 1;
> >>
> >> -               if (cfg_use_cmsg) {
> >> +               if (cfg_use_cmsg || cfg_use_cmsg_opt_id) {
> >>                          memset(control, 0, sizeof(control));
> >>
> >>                          msg.msg_control =3D control;
> >> -                       msg.msg_controllen =3D sizeof(control);
> >> +                       msg.msg_controllen =3D cfg_use_cmsg * CMSG_SPA=
CE(sizeof(uint32_t));
> >> +                       msg.msg_controllen +=3D cfg_use_cmsg_opt_id * =
CMSG_SPACE(sizeof(uint32_t));
> >>
> >> -                       cmsg =3D CMSG_FIRSTHDR(&msg);
> >> -                       cmsg->cmsg_level =3D SOL_SOCKET;
> >> -                       cmsg->cmsg_type =3D SO_TIMESTAMPING;
> >> -                       cmsg->cmsg_len =3D CMSG_LEN(sizeof(uint32_t));
> >> +                       cmsg =3D NULL;
> >
> > nit: we don't need to initialize it with NULL since it will be init
> > one way or another in the following code.
>
> NULL initialization is needed here because I use cmsg as a flag to
> choose between CMSG_FIRSTHDR or CMSG_NXTHDR.
>
> >> +                       if (cfg_use_cmsg) {
> >> +                               cmsg =3D CMSG_FIRSTHDR(&msg);
> >> +                               cmsg->cmsg_level =3D SOL_SOCKET;
> >> +                               cmsg->cmsg_type =3D SO_TIMESTAMPING;
> >> +                               cmsg->cmsg_len =3D CMSG_LEN(sizeof(uin=
t32_t));
> >> +
> >> +                               *((uint32_t *)CMSG_DATA(cmsg)) =3D rep=
ort_opt;
> >> +                       }
> >> +                       if (cfg_use_cmsg_opt_id) {
> >> +                               cmsg =3D cmsg ? CMSG_NXTHDR(&msg, cmsg=
) : CMSG_FIRSTHDR(&msg);
>
> This line has the check.

Oh, I miss that.

>
> >> +                               cmsg->cmsg_level =3D SOL_SOCKET;
> >> +                               cmsg->cmsg_type =3D SCM_TS_OPT_ID;
> >> +                               cmsg->cmsg_len =3D CMSG_LEN(sizeof(uin=
t32_t));
> >> +
> >> +                               *((uint32_t *)CMSG_DATA(cmsg)) =3D ts_=
opt_id;
> >> +                               saved_tskey =3D ts_opt_id;
> >> +                       }
> >>
> >> -                       *((uint32_t *) CMSG_DATA(cmsg)) =3D report_opt=
;
> >>                  }
> >>
> >>                  val =3D sendmsg(fd, &msg, 0);
> >> @@ -681,6 +702,7 @@ static void __attribute__((noreturn)) usage(const =
char *filepath)
> >>                          "  -L    listen on hostname and port\n"
> >>                          "  -n:   set no-payload option\n"
> >>                          "  -N:   print timestamps and durations in ns=
ec (instead of usec)\n"
> >> +                       "  -o N: use SCM_TS_OPT_ID control message to =
provide N as tskey\n"
> >>                          "  -p N: connect to port N\n"
> >>                          "  -P:   use PF_PACKET\n"
> >>                          "  -r:   use raw\n"
> >> @@ -701,7 +723,7 @@ static void parse_opt(int argc, char **argv)
> >>          int c;
> >>
> >>          while ((c =3D getopt(argc, argv,
> >> -                               "46bc:CeEFhIl:LnNp:PrRS:t:uv:V:x")) !=
=3D -1) {
> >> +                               "46bc:CeEFhIl:LnNo:p:PrRS:t:uv:V:x")) =
!=3D -1) {
> >>                  switch (c) {
> >>                  case '4':
> >>                          do_ipv6 =3D 0;
> >> @@ -742,6 +764,10 @@ static void parse_opt(int argc, char **argv)
> >>                  case 'N':
> >>                          cfg_print_nsec =3D true;
> >>                          break;
> >> +               case 'o':
> >> +                       ts_opt_id =3D strtoul(optarg, NULL, 10);
> >> +                       cfg_use_cmsg_opt_id =3D true;
> >> +                       break;
> >>                  case 'p':
> >>                          dest_port =3D strtoul(optarg, NULL, 10);
> >>                          break;
> >> @@ -799,6 +825,8 @@ static void parse_opt(int argc, char **argv)
> >>                  error(1, 0, "cannot ask for pktinfo over pf_packet");
> >>          if (cfg_busy_poll && cfg_use_epoll)
> >>                  error(1, 0, "pass epoll or busy_poll, not both");
> >> +       if (cfg_proto !=3D SOCK_DGRAM && cfg_use_cmsg_opt_id)
> >> +               error(1, 0, "control message TS_OPT_ID can only be use=
d with udp socket");
> >>
> >>          if (optind !=3D argc - 1)
> >>                  error(1, 0, "missing required hostname argument");
> >> diff --git a/tools/testing/selftests/net/txtimestamp.sh b/tools/testin=
g/selftests/net/txtimestamp.sh
> >> index 25baca4b148e..7894628a9355 100755
> >> --- a/tools/testing/selftests/net/txtimestamp.sh
> >> +++ b/tools/testing/selftests/net/txtimestamp.sh
> >> @@ -39,6 +39,7 @@ run_test_tcpudpraw() {
> >>
> >>          run_test_v4v6 ${args}           # tcp
> >>          run_test_v4v6 ${args} -u        # udp
> >> +       run_test_v4v6 ${args} -u -o 5   # udp with fixed tskey
> >
> > Could we also add another test with "-C" based on the above command?
> > It can test when both ID related flags are set, which will be helpful
> > in the future :)
>
> yep, sure, I'll add it in the next iteration.

Thanks!

