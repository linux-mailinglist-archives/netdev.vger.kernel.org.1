Return-Path: <netdev+bounces-81735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3B888AEDA
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 19:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007DE320EFB
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 18:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1EE57308;
	Mon, 25 Mar 2024 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bVp1UM/G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C92F57321
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 18:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391972; cv=none; b=d02fCR9cRfzAW8Xphm6o/lcyL+uZly/b5s5zNXmRNSC7pq2VUNAoLtnP5vSf0XyfH0O8pnJK1s0NDVArHHWIrKfbwKr7mBI6HlBp5mQfMy5JNhNDwkCuy/Ztv2VKbZ1Fr5ovAyu7fwCdL7onlyWLZ6afkGzB9VXbHisGUGUPUIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391972; c=relaxed/simple;
	bh=pLSup3gGjs3JbOl1YzR88fM025ougyI/vM5eZ+kG3qE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ifjLJwrFVpSj5C4PwyFJPlpFIY4KniMLHv8btb6hiY43zC2r5ajSUJyfkFI1Hpxar+pxO5MvnDVGc1OaygY4nNtqRrJTwXW5U+DvoCnHGBHzHTOlRwwzu/iWPQWIpeDqqdtiJ3qOX5M4XTtQLycOwj5kPWahv3/NjsV2ou4Opgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bVp1UM/G; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5a47cecb98bso2780760eaf.0
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 11:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1711391969; x=1711996769; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pLSup3gGjs3JbOl1YzR88fM025ougyI/vM5eZ+kG3qE=;
        b=bVp1UM/GGW64tro0hXV/WUU9FmpS53SsF6MfaRFXGferdx+b36n2qWkihnuqXYCANz
         DQMEdjQECSK7q74Nm9+O1cftixvv/t5JytGzRwY16volGvytXI3Gwz2KUGDpzoMbJ5iW
         XbCaXMH9/w+PymfngbFusgqgtbWCe3VbYQsE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711391969; x=1711996769;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pLSup3gGjs3JbOl1YzR88fM025ougyI/vM5eZ+kG3qE=;
        b=PEQP/0CV9PrIgOH+fu1xFObAx90xuRmUBH3WWhAdmJVwTViyXl+/CLOy6XTWWVzru8
         N1pRl09eqPJ5gwqVlCUPaOcGjaqsMs8TahjbaGea8IfdE/htFAlFEux/VmuVrfsHdF7q
         xQARDnFtZM6CSjOyD4MCB/8fsnhYzoGRZcaVQGe8PL343YVsgf2d/BeaK9bVD1auk4cB
         2hc8/ucguiNybV2XVl6FuR/ummPeN2TciThIWN32fQADkvIZPjuBIqB1ejCDahQYNK+I
         B4FdDSYOSchgRaxM7aLS8xM6zZMlewn61u31Ye83XT7ouNlq7oYVc2Fpb+MdYBT+V8j2
         Lnhg==
X-Gm-Message-State: AOJu0YwV/8jRXaq6S0HruVMYtpB+s5YtgzlmXBYBpZ5ZjHEL3k0+IrRr
	S2GFoVdXMJARSZzPkIiLsZtqW0/px4dmJczi3m859M1Gei7G2YSz1rXMDscHg6Mx/+/0QZ6fIrM
	ebqrAnlrRk2x37Xn/Bw6yRW+HIX6yZjEZuGqDkFS0nrfbptUQAfjOemtz87HEnVhAddFZE2B6Y0
	2NAubWUWSFvVnyoQekw0LUQ4yp3iT7
X-Google-Smtp-Source: AGHT+IEE3dxBhEOQ5NY+ZxZkhfsKFJexqb04MG4hYYC43yI95b+oAfC/fUVPuXRjKjRFF6HrR4udV0hcW5jkC+3FELA=
X-Received: by 2002:a05:6820:3087:b0:5a1:bb9d:56a7 with SMTP id
 eu7-20020a056820308700b005a1bb9d56a7mr8017964oob.8.1711391968500; Mon, 25 Mar
 2024 11:39:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHb6Lvo7kZ666_PWpq_LUQ31H1MsuKXyVn=h0V2SF=zUb=sjeg@mail.gmail.com>
In-Reply-To: <CAHb6Lvo7kZ666_PWpq_LUQ31H1MsuKXyVn=h0V2SF=zUb=sjeg@mail.gmail.com>
From: Bob McMahon <bob.mcmahon@broadcom.com>
Date: Mon, 25 Mar 2024 11:39:17 -0700
Message-ID: <CAHb6LvrvbOTVG=PGcuskM02EBG93MExgR0WL3bgnwMxjaoaVeA@mail.gmail.com>
Subject: Fwd: iperf 2-2-0-rc (release candidate)
To: netdev@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006216ad0614807e69"

--0000000000006216ad0614807e69
Content-Type: multipart/alternative; boundary="0000000000005acbdd0614807e73"

--0000000000005acbdd0614807e73
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

---------- Forwarded message ---------
From: Bob McMahon <bob.mcmahon@broadcom.com>
Date: Mon, Mar 25, 2024 at 11:26=E2=80=AFAM
Subject: iperf 2-2-0-rc (release candidate)
To: iPerf User Group <iperf-users@lists.sourceforge.net>


Hi All,

iperf 2 has a release candidate ready for users to try. It's on sourceforge
<https://sourceforge.net/projects/iperf2/> as iperf 2-2-0-rc. Please file
tickets on sourceforge <https://sourceforge.net/p/iperf2/tickets/> as well.

Release notes:

2.2.0 (as of March 14th, 2024
------------------------------
o new ./configure --enable-summing-debug option to help with summing debug
o select ahead of writes slow down UDP performance. support ./configure
--disable-write-select
o support fo -b 0 with UDP, unlimited load or no delay between writes
o support for --sync-transfer-id so client and server will match the ids
and give a remap message
o support --dscp command line option
o support for application level retries and minimum retry interval of the
TCP connect() syscall via --connect-retry-time and --connect-retry-timer,
repsectively
o support for --ignore-shutdown so test will end on writes vs the BDP drain
and TCP close/shutdown, recommended not to use this but in rare cases
o support for --fq-rate-step and --fq-rate-step-interval
o CCAs per --tcp-cca, --tcp-congestion, etc neeed to be case sensitive
o support for both packets and bytes inflight taken from tcp_info struct
amd pkt calc of (tcp_info_buf.tcpi_unacked - tcp_info_buf.tcpi_sacked -
tcp_info_buf.tcpi_lost + tcp_info_buf.tcpi_retrans)
o man page updates and -h to reflect new options, better descriptions
o lots of work around summing with parallel threads, new implementation
based on interval or slot counters, hopefully should work reliably
o --bounceback tests are much more reliable and robust
o Improve event handling around select timeouts, helps with larger -P
values and summing
o use the getsockopt IP_TOS for the displayed output, warn when set and get
don't match
o better tos byte output, include dscp and ecn fields individually
o better tos setting code for both v6 and v4, so they behave the same
around checks and warnings
o much better NULL events to help with reporter processing even when
traffic is not flowing
o support for a new string report
o python flows work around CDF based tests
o rate limit fflush calls to a max of one every millisecond or 1000 per sec
o remove superfulous fflush calls
o reports when P =3D 1 and --sum-only need sum outputs
o enable summing with --incr-dstip
o add macro TIME_GET_NOW to set a struct timeval in a portable manner
o code readability improvements with enums, bools, etc.
o fix for TCP rate limited and -l less than min burst size
o only use linux/tcp.h when absolutely needed, otherwise use netinet/tcp.h
o print bounceback OWD tx/rx in interval reports
o add flows Makefiles for tarball or make dist-all
o support interval reports for bounceback histograms
o support for TCP working loads and UDP primary flows, including UDP
isochronous, per ticket 283
o fix working-load with isoch so working-load streams are capacity seeking
o exit when CCA not supported or read of the current CCA doesn't match
requested CCA
o add more make check tests
o add support for omit string (omit code not ready for this release)
o pyflows qdisc settings and outputs
o add first send pacing with --tx-starttime so listener threads udp_accept
has time to perform udp_accept() between the client threads
o adjust the sender time per the client delay and the client first write,
i.e. subtract out this delay in the calculations
o fixes for small packets and --tx-starttime
o use more modern multicast socket options (now in
src/iperf_multicast_api.c)
o warn on bind port not sent with --incr-srcport
o display fq-rate values in outputs when --fq-rate is used
o add support for --test-exchange-timeout
o fixes around wait_tick
o add support for TCP_TX_DELAY via --tcp-tx-delay <val ms> option on both
client and server
o pass the CCA from client to server
o support burst-size with different write sizes and don't require
--burst-period
o output traffic thread send scheduling error stats in final ouput
o output clock unsync stats with --bounceback
o add warn message on MSG_CTRUNC
o UDP select fixes
o enable TCP_NOTSENTLOWAT and set to a default small value with
--tcp-write-times
o default histogram max binning to 10 seconds
o add a max timestamp to histogram outputs so user can find packets in
pcaps or equivalent
o autoconf change for struct ip_mreqn
o print errno on writen fail

--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

--0000000000005acbdd0614807e73
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">---------- Forwarded message ---------<br>From: <strong cla=
ss=3D"gmail_sendername" dir=3D"auto">Bob McMahon</strong> <span dir=3D"auto=
">&lt;<a href=3D"mailto:bob.mcmahon@broadcom.com">bob.mcmahon@broadcom.com<=
/a>&gt;</span><br>Date: Mon, Mar 25, 2024 at 11:26=E2=80=AFAM<br>Subject: i=
perf 2-2-0-rc (release candidate)<br>To: iPerf User Group &lt;<a href=3D"ma=
ilto:iperf-users@lists.sourceforge.net">iperf-users@lists.sourceforge.net</=
a>&gt;<br></div><br><br><div dir=3D"ltr">Hi All,<div><br></div><div>iperf 2=
 has a release candidate ready for users to try. It&#39;s <a href=3D"https:=
//sourceforge.net/projects/iperf2/" target=3D"_blank">on sourceforge</a> as=
 iperf 2-2-0-rc. Please <a href=3D"https://sourceforge.net/p/iperf2/tickets=
/" target=3D"_blank">file tickets on sourceforge</a>=C2=A0as well.<br><br>R=
elease notes:<br><br>2.2.0 (as of March 14th, 2024<br>---------------------=
---------<br>o new ./configure --enable-summing-debug option to help with s=
umming debug<br>o select ahead of writes slow down UDP performance. support=
 ./configure --disable-write-select<br>o support fo -b 0 with UDP, unlimite=
d load or no delay between writes<br>o support for --sync-transfer-id so cl=
ient and server will match the ids and give a remap message<br>o support --=
dscp command line option<br>o support for application level retries and min=
imum retry interval of the TCP connect() syscall via --connect-retry-time a=
nd --connect-retry-timer, repsectively<br>o support for --ignore-shutdown s=
o test will end on writes vs the BDP drain and TCP close/shutdown, recommen=
ded not to use this but in rare cases<br>o support for --fq-rate-step and -=
-fq-rate-step-interval<br>o CCAs per --tcp-cca, --tcp-congestion, etc neeed=
 to be case sensitive<br>o support for both packets and bytes inflight take=
n from tcp_info struct amd pkt calc of (tcp_info_buf.tcpi_unacked - tcp_inf=
o_buf.tcpi_sacked - tcp_info_buf.tcpi_lost + tcp_info_buf.tcpi_retrans)<br>=
o man page updates and -h to reflect new options, better descriptions<br>o =
lots of work around summing with parallel threads, new implementation based=
 on interval or slot counters, hopefully should work reliably<br>o --bounce=
back tests are much more reliable and robust<br>o Improve event handling ar=
ound select timeouts, helps with larger -P values and summing<br>o use the =
getsockopt IP_TOS for the displayed output, warn when set and get don&#39;t=
 match<br>o better tos byte output, include dscp and ecn fields individuall=
y<br>o better tos setting code for both v6 and v4, so they behave the same =
around checks and warnings<br>o much better NULL events to help with report=
er processing even when traffic is not flowing<br>o support for a new strin=
g report<br>o python flows work around CDF based tests<br>o rate limit fflu=
sh calls to a max of one every millisecond or 1000 per sec<br>o remove supe=
rfulous fflush calls<br>o reports when P =3D 1 and --sum-only need sum outp=
uts<br>o enable summing with --incr-dstip<br>o add macro TIME_GET_NOW to se=
t a struct timeval in a portable manner<br>o code readability improvements =
with enums, bools, etc.<br>o fix for TCP rate limited and -l less than min =
burst size<br>o only use linux/tcp.h when absolutely needed, otherwise use =
netinet/tcp.h<br>o print bounceback OWD tx/rx in interval reports<br>o add =
flows Makefiles for tarball or make dist-all<br>o support interval reports =
for bounceback histograms<br>o support for TCP working loads and UDP primar=
y flows, including UDP isochronous, per ticket 283<br>o fix working-load wi=
th isoch so working-load streams are capacity seeking<br>o exit when CCA no=
t supported or read of the current CCA doesn&#39;t match requested CCA<br>o=
 add more make check tests<br>o add support for omit string (omit code not =
ready for this release)<br>o pyflows qdisc settings and outputs<br>o add fi=
rst send pacing with --tx-starttime so listener threads udp_accept has time=
 to perform udp_accept() between the client threads<br>o adjust the sender =
time per the client delay and the client first write, i.e. subtract out thi=
s delay in the calculations<br>o fixes for small packets and --tx-starttime=
<br>o use more modern multicast socket options (now in src/iperf_multicast_=
api.c)<br>o warn on bind port not sent with --incr-srcport<br>o display fq-=
rate values in outputs when --fq-rate is used<br>o add support for --test-e=
xchange-timeout<br>o fixes around wait_tick<br>o add support for TCP_TX_DEL=
AY via --tcp-tx-delay &lt;val ms&gt; option on both client and server<br>o =
pass the CCA from client to server<br>o support burst-size with different w=
rite sizes and don&#39;t require --burst-period<br>o output traffic thread =
send scheduling error stats in final ouput<br>o output clock unsync stats w=
ith --bounceback<br>o add warn message on MSG_CTRUNC<br>o UDP select fixes<=
br>o enable TCP_NOTSENTLOWAT and set to a default small value with --tcp-wr=
ite-times<br>o default histogram max binning to 10 seconds<br>o add a max t=
imestamp to histogram outputs so user can find packets in pcaps or equivale=
nt<br>o autoconf change for struct ip_mreqn<br>o print errno on writen fail=
<br></div></div>
</div></div>

<br>
<span style=3D"background-color:rgb(255,255,255)"><font size=3D"2">This ele=
ctronic communication and the information and any files transmitted with it=
, or attached to it, are confidential and are intended solely for the use o=
f the individual or entity to whom it is addressed and may contain informat=
ion that is confidential, legally privileged, protected by privacy laws, or=
 otherwise restricted from disclosure to anyone else. If you are not the in=
tended recipient or the person responsible for delivering the e-mail to the=
 intended recipient, you are hereby notified that any use, copying, distrib=
uting, dissemination, forwarding, printing, or copying of this e-mail is st=
rictly prohibited. If you received this e-mail in error, please return the =
e-mail to the sender, delete it from your computer, and destroy any printed=
 copy of it.</font></span>
--0000000000005acbdd0614807e73--

--0000000000006216ad0614807e69
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
X5dfkSef9T/DbsDM0PeTVMVyYIQoRSMBIGxVkaqp0MJglvQ2mU4CXcoOGgm6XC8LoLoEvYojXFKC
fRgCOT5xeMR10UPSBQIljKwt7fPhpYVY+jTtOclpAgMBAAGjggHZMIIB1TAOBgNVHQ8BAf8EBAMC
BaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGG
NWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0G
A1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxz
aWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3JsMCMGA1UdEQQc
MBqBGGJvYi5tY21haG9uQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSME
GDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUpG/4RP1YQA/iXGens9pIRe7CQxMw
DQYJKoZIhvcNAQELBQADggEBACfWLy4qJyCnOa3sl4LEDAMU/gmJ6LbclGE5iR4KanAmlAt92gzN
5lSy/iE+wsRrXiHI7YKFgXX1kVK/RqMiPRrw4hq2j8nxoSi/VFiyS3CsfVMGkbY7HBTlBvla/tH+
+2nJprlXbJyz1GdvoJAeam5RvTWotcCGAjZmMa3U3zMkszgXN849xe3dUK1DauUGiInXEwEdXDcA
/0CVjL3EEMj+kNWcLhrSZKwFtxggUyMW3XWRaAeAL9wOtEaXYqlgbtnV0n9FuoV2TNm3h7Mh7rjV
I2zM+IZ3DE+XFK7dcPwte33u75QyySNJ3UMZqi25CO85yl8Bmo7aWRm99N7HGnkxggJtMIICaQIB
ATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhH
bG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwxrOEJauTmSvZnA80wDQYJ
YIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOrJynpUldPZsAQczrAvCL9nc1fgb6jXBjne
jnZ4eTH1MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMyNTE4
MzkyOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQBxNVgxbvMltcNDeCSLEMPUkGpDe+lBwPXo9DlVpkYMuZ4u1ZyCeX3v
9sebThSY/C8l/dAYBhd3YksYAd4juxOp/Hs1aEZY/5z7fDL7mUtvjQgiDQLsO3HacWWNxor+/LyZ
jvReInloZQt4rGUjB2MIIW+AwdUdLRqudkoI+Rt96qUJuupydMsT4NiTOXyCPrS6lKZ7bG3M90XW
wCP4zu3nlZQ2IMH7f2PN2ZrkYh8gL0ANder4rC3w2LPWVsCYb7n8HayRDwMeqC5RxZLskbR/b95r
nQ1/O5pzHS7fok4D2Y9gA8rsfoK/gqVjIeT/70nnWmBMjPebcn4vaw0HlXpu
--0000000000006216ad0614807e69--

