Return-Path: <netdev+bounces-124068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAEE967D5C
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 03:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9D61F20FA0
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 01:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD5A1BF37;
	Mon,  2 Sep 2024 01:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUrQtuPW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7725B208A7
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 01:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725240613; cv=none; b=V48cm/DygY3t2uwPzOvwAueoG9ReylJjaYhxLWT9Ra/A2VLlnMWcTcMJoN9cF56gHv5nSH6VmyTzqUH2t9mIPm1zrI/a9vOT/TlIt2eTMU4Tvgi6OPeGqGwUsutS1q08qQHtlOwbsf4T/ykZI/JFEeUkrcpuoB1d97eGf28VDOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725240613; c=relaxed/simple;
	bh=xikYwE3z0Vq5bQPvBc9/NQzAlAcu7aPn6YNlN+X/S8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsHhZK8bxoCiGnNDcjYjAtntsaXPKQkUSbI2/oZP99qmISxBc0AcitAMmlaxfRHVtAJi8yThfz4lesrRYLuScrguBFPAF4i99jNPJBGPrbrEbcrBaCpDSUnC/sIuiGINeB47ALHzz3ltXyrZUFfTqVMklFH76OD1mO3tlpLbT/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUrQtuPW; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-82a24deca03so115571539f.0
        for <netdev@vger.kernel.org>; Sun, 01 Sep 2024 18:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725240610; x=1725845410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/kegE+5eg2HMOA2M2ori/64bxLSgv0kk7kk8I5nHow=;
        b=YUrQtuPWxNhyi2DZK5gLAW+NVMAXidW69VE3pUao6yTQpuHf6r0V+GPELT2D9OJjog
         8QKtuANuQI/jUFd14LnuRDjE4vI8P9V6PXuKlRiryxHi8I6KElCt8+x6nVGeeQaUZQ7F
         uQK3QejyoFPImeXObFTyA0q1cjMSY80yljUHPmhJPfm3j2/ZAxHrBTYg++lhGdO3vkiO
         3RkiuFx2k987Opv2zlz9fXGkmwPQt7SSkiKYOdmxB8QKSe860TCGIfiWJYb2YHvZrK/G
         gGh6afYE6uiFCq5UxOHcP0Esux7eoC8PnQZX2iYvrwV38xLGYDdr1qDBBCqUUc/UPHyh
         gKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725240610; x=1725845410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/kegE+5eg2HMOA2M2ori/64bxLSgv0kk7kk8I5nHow=;
        b=ue6B5cSfet3lV82dYJvclbBzwWuTlGzIliLZsmfTKWv0LbOtouJfzxe62Jo7M35O7b
         LC78+Gexw79HDIlaTnFs69IB3m2M+pNVzOi7KmmB1FB5SgXRxjFfJ+NNsUyt5N/N1xg9
         0XHwXIOZNxbeg7UzuKXKIuI0uBAPgxcLLd1pSF1blTLLUqr1PGjSIDL8i937WFSA2S20
         ZJyb/IuBuRb2CNJpX2466I/TPpCVdazhv2LNH4TZCAJt5EZRobCR5Lm7X5Su+2816M84
         sQXjrR0GdxYsVhwgX69TGoSyO2rXy3zgF0aMKX3O95zp3yA3dgl/aI5MV4fsSSnt2urg
         3DvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoRyar1IPZjR1CpiUgCiFUIeS23L8yeNH+48Zxu2apVjtXKYzZBq3H72V+kGH3+ckO6UgKVJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAiVBFeKTUJjj9WgUrLy7sfo3AtUGxjHfhvUrcNgFIBl5Vwe3W
	G44UQx4HPdcBv9rlgCDBRnfVn8zwQLR1YI/zySRQlOGTevHzXQ8uFvtSYlQ9uBE0w04FQWPTZou
	MynL1oyaVtMPP/VXsujwE6VgXhLU=
X-Google-Smtp-Source: AGHT+IFbKv4QkTatTHFgMlttEPexBu7C585E5YR1bNEZUE9PTCycgzuy15tUFbV9tJofUQClLl9oQfOwiCcrRBdk4GU=
X-Received: by 2002:a05:6e02:148a:b0:39d:1dda:fe9 with SMTP id
 e9e14a558f8ab-39f4f681eb1mr56846835ab.5.1725240610363; Sun, 01 Sep 2024
 18:30:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829204922.1674865-1-vadfed@meta.com> <20240829204922.1674865-2-vadfed@meta.com>
In-Reply-To: <20240829204922.1674865-2-vadfed@meta.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 2 Sep 2024 09:29:34 +0800
Message-ID: <CAL+tcoCeQ5R9Pp=__hi6xuQzACj9v1+TQarMky8c2nzcBN0+Xg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] selftests: txtimestamp: add SCM_TS_OPT_ID test
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Willem de Bruijn <willemb@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Vadim,

On Fri, Aug 30, 2024 at 4:55=E2=80=AFAM Vadim Fedorenko <vadfed@meta.com> w=
rote:
>
> Extend txtimestamp udp test to run with fixed tskey using
> SCM_TS_OPT_ID control message.
>
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
>  tools/include/uapi/asm-generic/socket.h    |  2 +
>  tools/testing/selftests/net/txtimestamp.c  | 48 +++++++++++++++++-----
>  tools/testing/selftests/net/txtimestamp.sh |  1 +
>  3 files changed, 41 insertions(+), 10 deletions(-)
>
> diff --git a/tools/include/uapi/asm-generic/socket.h b/tools/include/uapi=
/asm-generic/socket.h
> index 54d9c8bf7c55..281df9139d2b 100644
> --- a/tools/include/uapi/asm-generic/socket.h
> +++ b/tools/include/uapi/asm-generic/socket.h
> @@ -124,6 +124,8 @@
>  #define SO_PASSPIDFD           76
>  #define SO_PEERPIDFD           77
>
> +#define SCM_TS_OPT_ID          78
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG =3D=3D 64 || (defined(__x86_64__) && defined(__ILP32=
__))
> diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testing/se=
lftests/net/txtimestamp.c
> index ec60a16c9307..3a8f716e72ae 100644
> --- a/tools/testing/selftests/net/txtimestamp.c
> +++ b/tools/testing/selftests/net/txtimestamp.c
> @@ -54,6 +54,10 @@
>  #define USEC_PER_SEC   1000000L
>  #define NSEC_PER_SEC   1000000000LL
>
> +#ifndef SCM_TS_OPT_ID
> +# define SCM_TS_OPT_ID 78
> +#endif
> +
>  /* command line parameters */
>  static int cfg_proto =3D SOCK_STREAM;
>  static int cfg_ipproto =3D IPPROTO_TCP;
> @@ -77,6 +81,8 @@ static bool cfg_epollet;
>  static bool cfg_do_listen;
>  static uint16_t dest_port =3D 9000;
>  static bool cfg_print_nsec;
> +static uint32_t ts_opt_id;
> +static bool cfg_use_cmsg_opt_id;
>
>  static struct sockaddr_in daddr;
>  static struct sockaddr_in6 daddr6;
> @@ -136,12 +142,13 @@ static void validate_key(int tskey, int tstype)
>         /* compare key for each subsequent request
>          * must only test for one type, the first one requested
>          */
> -       if (saved_tskey =3D=3D -1)
> +       if (saved_tskey =3D=3D -1 || cfg_use_cmsg_opt_id)
>                 saved_tskey_type =3D tstype;
>         else if (saved_tskey_type !=3D tstype)
>                 return;
>
>         stepsize =3D cfg_proto =3D=3D SOCK_STREAM ? cfg_payload_len : 1;
> +       stepsize =3D cfg_use_cmsg_opt_id ? 0 : stepsize;
>         if (tskey !=3D saved_tskey + stepsize) {
>                 fprintf(stderr, "ERROR: key %d, expected %d\n",
>                                 tskey, saved_tskey + stepsize);
> @@ -480,7 +487,7 @@ static void fill_header_udp(void *p, bool is_ipv4)
>
>  static void do_test(int family, unsigned int report_opt)
>  {
> -       char control[CMSG_SPACE(sizeof(uint32_t))];
> +       char control[2 * CMSG_SPACE(sizeof(uint32_t))];
>         struct sockaddr_ll laddr;
>         unsigned int sock_opt;
>         struct cmsghdr *cmsg;
> @@ -620,18 +627,32 @@ static void do_test(int family, unsigned int report=
_opt)
>                 msg.msg_iov =3D &iov;
>                 msg.msg_iovlen =3D 1;
>
> -               if (cfg_use_cmsg) {
> +               if (cfg_use_cmsg || cfg_use_cmsg_opt_id) {
>                         memset(control, 0, sizeof(control));
>
>                         msg.msg_control =3D control;
> -                       msg.msg_controllen =3D sizeof(control);
> +                       msg.msg_controllen =3D cfg_use_cmsg * CMSG_SPACE(=
sizeof(uint32_t));
> +                       msg.msg_controllen +=3D cfg_use_cmsg_opt_id * CMS=
G_SPACE(sizeof(uint32_t));
>
> -                       cmsg =3D CMSG_FIRSTHDR(&msg);
> -                       cmsg->cmsg_level =3D SOL_SOCKET;
> -                       cmsg->cmsg_type =3D SO_TIMESTAMPING;
> -                       cmsg->cmsg_len =3D CMSG_LEN(sizeof(uint32_t));
> +                       cmsg =3D NULL;

nit: we don't need to initialize it with NULL since it will be init
one way or another in the following code.

> +                       if (cfg_use_cmsg) {
> +                               cmsg =3D CMSG_FIRSTHDR(&msg);
> +                               cmsg->cmsg_level =3D SOL_SOCKET;
> +                               cmsg->cmsg_type =3D SO_TIMESTAMPING;
> +                               cmsg->cmsg_len =3D CMSG_LEN(sizeof(uint32=
_t));
> +
> +                               *((uint32_t *)CMSG_DATA(cmsg)) =3D report=
_opt;
> +                       }
> +                       if (cfg_use_cmsg_opt_id) {
> +                               cmsg =3D cmsg ? CMSG_NXTHDR(&msg, cmsg) :=
 CMSG_FIRSTHDR(&msg);
> +                               cmsg->cmsg_level =3D SOL_SOCKET;
> +                               cmsg->cmsg_type =3D SCM_TS_OPT_ID;
> +                               cmsg->cmsg_len =3D CMSG_LEN(sizeof(uint32=
_t));
> +
> +                               *((uint32_t *)CMSG_DATA(cmsg)) =3D ts_opt=
_id;
> +                               saved_tskey =3D ts_opt_id;
> +                       }
>
> -                       *((uint32_t *) CMSG_DATA(cmsg)) =3D report_opt;
>                 }
>
>                 val =3D sendmsg(fd, &msg, 0);
> @@ -681,6 +702,7 @@ static void __attribute__((noreturn)) usage(const cha=
r *filepath)
>                         "  -L    listen on hostname and port\n"
>                         "  -n:   set no-payload option\n"
>                         "  -N:   print timestamps and durations in nsec (=
instead of usec)\n"
> +                       "  -o N: use SCM_TS_OPT_ID control message to pro=
vide N as tskey\n"
>                         "  -p N: connect to port N\n"
>                         "  -P:   use PF_PACKET\n"
>                         "  -r:   use raw\n"
> @@ -701,7 +723,7 @@ static void parse_opt(int argc, char **argv)
>         int c;
>
>         while ((c =3D getopt(argc, argv,
> -                               "46bc:CeEFhIl:LnNp:PrRS:t:uv:V:x")) !=3D =
-1) {
> +                               "46bc:CeEFhIl:LnNo:p:PrRS:t:uv:V:x")) !=
=3D -1) {
>                 switch (c) {
>                 case '4':
>                         do_ipv6 =3D 0;
> @@ -742,6 +764,10 @@ static void parse_opt(int argc, char **argv)
>                 case 'N':
>                         cfg_print_nsec =3D true;
>                         break;
> +               case 'o':
> +                       ts_opt_id =3D strtoul(optarg, NULL, 10);
> +                       cfg_use_cmsg_opt_id =3D true;
> +                       break;
>                 case 'p':
>                         dest_port =3D strtoul(optarg, NULL, 10);
>                         break;
> @@ -799,6 +825,8 @@ static void parse_opt(int argc, char **argv)
>                 error(1, 0, "cannot ask for pktinfo over pf_packet");
>         if (cfg_busy_poll && cfg_use_epoll)
>                 error(1, 0, "pass epoll or busy_poll, not both");
> +       if (cfg_proto !=3D SOCK_DGRAM && cfg_use_cmsg_opt_id)
> +               error(1, 0, "control message TS_OPT_ID can only be used w=
ith udp socket");
>
>         if (optind !=3D argc - 1)
>                 error(1, 0, "missing required hostname argument");
> diff --git a/tools/testing/selftests/net/txtimestamp.sh b/tools/testing/s=
elftests/net/txtimestamp.sh
> index 25baca4b148e..7894628a9355 100755
> --- a/tools/testing/selftests/net/txtimestamp.sh
> +++ b/tools/testing/selftests/net/txtimestamp.sh
> @@ -39,6 +39,7 @@ run_test_tcpudpraw() {
>
>         run_test_v4v6 ${args}           # tcp
>         run_test_v4v6 ${args} -u        # udp
> +       run_test_v4v6 ${args} -u -o 5   # udp with fixed tskey

Could we also add another test with "-C" based on the above command?
It can test when both ID related flags are set, which will be helpful
in the future :)

Thanks,
Jason

>         run_test_v4v6 ${args} -r        # raw
>         run_test_v4v6 ${args} -R        # raw (IPPROTO_RAW)
>         run_test_v4v6 ${args} -P        # pf_packet
> --
> 2.43.5
>
>

