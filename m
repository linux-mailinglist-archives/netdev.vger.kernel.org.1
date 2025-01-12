Return-Path: <netdev+bounces-157500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BE7A0A754
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 06:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D94727A303C
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 05:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6AF1487D1;
	Sun, 12 Jan 2025 05:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QuzzhoDz"
X-Original-To: netdev@vger.kernel.org
Received: from sonic322-27.consmr.mail.bf2.yahoo.com (sonic322-27.consmr.mail.bf2.yahoo.com [74.6.132.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E0DECF
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 05:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.132.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736661472; cv=none; b=cjs9pxYxfT9IjULeC72IEA+q/HZndOXlYg091JfKl8YjGjW0SdyZk0TG1PbYrRIxzkCvtn7YCOKuBlIprSiSb5v1qJWtiffdCUAlX/FSFYVYn1BYHmAr8VH8QjGwAjLOdNAj2C5c5CnOkv3kik+qQuio86uKBAwDXqUZwc76M7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736661472; c=relaxed/simple;
	bh=ydn9gFMoHGmGLiscsXlrHLwFSeeaxe/BH1QuAOVvmsA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=R4rPABXbDW6a+Xi9KUjf3q9Aa+G1cli03TwpJrdxQRhSmq3XOnUIxhS+MG2e3GUKIeMrSioOXY0xVywAe7ftMdOOOieL6DThPne55UPYxavbO32ox0xiKhKiypEfnL5FYhJY66zkb+ahEcDRFoxgHpFrH968+nQbj1elNDSrGGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=QuzzhoDz; arc=none smtp.client-ip=74.6.132.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1736661463; bh=ydn9gFMoHGmGLiscsXlrHLwFSeeaxe/BH1QuAOVvmsA=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=QuzzhoDzVhqOJAjbAhSGRfuJ8tTbqBpqPklfcHqVa8jKvN2yd20AHh9PvMnKVYk2OhCCAvNebUTtEJWMMQCp/1WzRcf4/WZhlBN01zTvYM5D/3xPNc5WaUj5uzpa6CBR824V5NtkCjDHnwexgsHIdlfltqU1CQGJKjTGExhRF6i7pYcHEaI7kpFGxAeblhNRmlfeWxJD5906YjALRxJDBOAAm6Zrc4mlRxbTrNLDBwzsqpty5e5yE+RefNwOZ0SK/uxJX6id4RQo2B8nV0gR6cgnOT5y+P3I6ubjczR2FMZbC+M4l9h6jI/IzruubKaVv3Vgrqb3wIA2FrkjY7g66Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1736661463; bh=VGSA24pJbp3Eh50RqnvVAr/yqQBMgb+unBQ8GjL1yn0=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=H/U2AX1KDrvch2u25kW38qGOLfMcHBl/KkxU6ae6fDy02S3FKXReZ+pywvYkK62Xejz6r/Tuu/XtE58T8xo/cCOMn1oB0hTE2gU3keRSHHjXsSUE84WQFwGquE9LVOPB1ZswB9157BuPwspLfFHSk01UD1mi3Wgt06+TUMMjAmaJIhEd/tXVsRO129/XGul9fu3/CX7PljNh4MnAMw7sS74bN0BUE4cPM+VRw4mHIK6gXS/6g+sF5bHKgkublWIEB7+nEWddkOHj9/bNO9wCt9y/LR04tJBoYqZdKdYBB66hZbz8pHUebrmkRgwZusNTxU3N5y+Rbj6+G9Ht/RQP8g==
X-YMail-OSG: 35877B4VM1mf.7C99_AFXED1meoHnH2.oSi6TjnpN8cPm7PZRBjKkZ6szx2Fth1
 0QUeb54js2dG748aKRfWu9.PnjsoEfr7qgwRRBnJ_AU6CZV.lj38mRf_sUVKNkOR2PKPBjpxDpJg
 hJc_NA4JRySm1mJSCJkNPLAQum5XEhPe1wBzmge2myOwzvlhBWpHU.T4jDZ2dkH44iUWr9PX9SQ9
 swVMNNXJx41zj1zYU_D.SIl0.7KFpi3p7JhCY3RkFuz6CS8Q_UZrdisFfjrQIAIexLucF84coQqn
 4Pt9wvNaTW5R1CM84Q561wIa0H4unE6ii0DohUJYczPtHlouUWDfhEelA1P2AsDFaf2LaP5TvPG9
 UYE_s22GqkR7Wilrcs0LswIu.5aIwNGiT3mL.DTxpvs31S.yB6gzcs1le.bMy7tZeiATIf5m7935
 _C0WCHenFVP6y9KpMfzGBhQa9QDD5aCpVikv4l35jpWKD4DUHu.xNcpOYf.59gCmbf5jY4qU1J08
 RQZbfq8o403NACAc_qMiwqXXiHWOzeKk8q43CyOQPsZcVHlsyX78iXYkOczFJv6eEPaTJ.a7Ghbk
 TPQGUw8c5YjQuDr7MLae3MbI47aRrbW3iDXjoOCHBzXONqDdMRrwBQgfWlQKwS9XDGA_jEjlhnMf
 MtPggG5SapyWzzHmkc.uPD4MCMRMyb6zrmzzFvanTinQZsw2auFQ5gl5YHKj3yb2SKdiM223nqfJ
 YPrI_oXap6UGOVRKXsGSWa9LRs90Ph.qCJTPH9oLQKW1hZly3bm_Y5IDCbzrmSQNBBCauF5iCXrG
 9iDCdnzZuWI76PQjkgHVZOcYE4LOyKbTO6wJP1hmrSTbUuh3qs2cmIouJQA2wuyzPt.GltN9pMnk
 jcj9tbVFG2bYHSnAysB1KjL_79EsO1J.r7y5amxuZXqFgdPlbcFttoyl2hjoBbnGF2TogoBDngKx
 Lcy_Sl0gL7TMo1MMlR7xAhcFbBQZi0zjLh4ITg_qMKVpEogAHjZHV37emygzjN3WAeC868xGCrSK
 jYHv4h_2lrnLsYv98c0QBvThQzD81yOLLG4ZYQ_nrKuAYiHEKeflDQgC7LRGXdWBirA9ZYHUdPy0
 Z2FLeAC0E9k759Rv.Dcc.pHhU_lp0_qCQ7TZc6NPsFatbUdJeJWDp14cKRukXCDrtKfu2sXB8cZ.
 2KH2tvd3gJe6H.vMLVttXFlHXV0kTGcdzRPheaHRIzdTfgYltT3HD2QPpsN6gr1FGysAoVV6Icam
 PNRXCONeF6v9cUJca9GVQDhGYv9PS3wsGg50Sw59554u5QzMg8oWeMHW4zP4YKZxAW1sUjodGyvJ
 jNzFlqXyt62XtRsiv1p47ns8gdbmA9R_mOw9Puz25.sAlilj1D2hLD1HWWJ1iReLFZ0jBcW7xGYR
 QKQjRly9IcEUmlnqMoZu9zWw_bpBqTlNQ_TAiLC8WR4YjRQmS.UYrsP4O8eQMDyrmyBLUE5kOGVS
 0gj_L5ov4TY0cBdGQq1hRAZIK_NSyCU_uGjF8Y2STuuml.eCz8SSToLrnwzinVlgd8G9pHs9Ec95
 mIBKvu1RY5NXkFcsqiBvu_5I7xBeIh.VkdVW9B55EIiAWHpcJ.T6iPes3WeIAXzjNnNYpSomtKDi
 6xTTJwUHf4P5jabTNm3vZhlnjvu8WNfUUqLhlwR9Zb93eiVkKxTFrqFuycZ7EVKNXtsJz4NOAqgw
 3p2zLwrXtHvp26vXRwqLwErCMtD2ub2bfEo1m9OGW8_CjzmjpyA4GYaAkY5CZ_YeiQhGuyUO8bm0
 oolc3q15F1hjVEkcOh1EDNAjIXwRmrxskDk0M5pw5Fg6KS_lgOCUdyyx_SCU1C5ch_InHqhF4_3Q
 G1CqykhUfyEHwnaW84soPYd5TJUibAyRTDfG1Z5iPpZr7dJYemaqfN368S7IV2wqdgtrqZE7izm6
 Hms7CUiCWhp.H0NXvC0AGChwk1ZIxYxX70HkT10h9NFxO2JJ4c1EbykNUbZ6LVkH1rJ5NZ8ZeC71
 pdUE6U5afvOrg2xnJA19gnarg6yeGPANwMtFvwxEHy6mNjxk7MoGMNdLS_CrdjUjKUHL9D6TtMGi
 yS2culzvlQPizRKSUp2J8lx0qAngEF48JxU5ml7onczg3TB.Xc0cyEycB1FpLnROy.5Xj3_llzbs
 4FwYEi2nxbd3ZAe_Y5JFuJaQ0F96zavcrTr43JvgineFltwUayGtkkkxkUs6xyHD75tBbjLQbSmO
 Q.5LqPuhhiA--
X-Sonic-MF: <ma.arghavani@yahoo.com>
X-Sonic-ID: 47ee2dec-65df-4b3d-b532-b0115002cc5e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic322.consmr.mail.bf2.yahoo.com with HTTP; Sun, 12 Jan 2025 05:57:43 +0000
Date: Sun, 12 Jan 2025 05:47:22 +0000 (UTC)
From: Mahdi Arghavani <ma.arghavani@yahoo.com>
To: Neal Cardwell <ncardwell@google.com>
Cc: Eric Dumazet <edumazet@google.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	Haibo Zhang <haibo.zhang@otago.ac.nz>, 
	David Eyers <david.eyers@otago.ac.nz>, 
	Abbas Arghavani <abbas.arghavani@mdu.se>
Message-ID: <1815460239.6961054.1736660842181@mail.yahoo.com>
In-Reply-To: <CADVnQymzCpJozeF-wMPbppizg0SUAUufgyQEeD7AB5DZDNBTEw@mail.gmail.com>
References: <408334417.4436448.1736139157134.ref@mail.yahoo.com> <408334417.4436448.1736139157134@mail.yahoo.com> <CANn89iLzo0Wk7p=dtUQ4Q2-pCAsjSxXZw71ngNTw6NZbEEvoDA@mail.gmail.com> <2046438615.4484034.1736328888690@mail.yahoo.com> <CADVnQymzCpJozeF-wMPbppizg0SUAUufgyQEeD7AB5DZDNBTEw@mail.gmail.com>
Subject: Re: [PATCH net] tcp_cubic: Fix for bug in HyStart implementation in
 the Linux kernel
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_6961053_754585562.1736660842181"
X-Mailer: WebService/1.1.23040 YMailNorrin

------=_Part_6961053_754585562.1736660842181
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

 Hi,
Thank you for your email.
Following your suggestion, I downloaded the latest packetdrill tests for CU=
BIC. Attached is a new script to test the HYSTART-ACK-TRAIN detection mecha=
nism. Additionally, it=E2=80=99s a good idea to set the hystart_detect para=
meter to 2 (instead of 3) in the "cubic-hystart-delay-*.pkt" files.

I recompiled the Linux kernel with the patch we both agreed on in the previ=
ous emails. However, I found that the fix passes all tests except for the f=
ollowing:
1) tcp/cubic/cubic-bulk-166k-idle-restart.pkt
2) tcp/cubic/cubic-bulk-166k.pkt

This is because these two tests assume that slow-start ends when cwnd =3D 4=
8, which is not correct. I will work on these two tests and get back to you=
 soon.

Best Wishes,
Mahdi Arghavani



On Friday, January 10, 2025 at 06:23:58 AM GMT+13, Neal Cardwell <ncardwell=
@google.com> wrote:=20


On Wed, Jan 8, 2025 at 4:36=E2=80=AFAM Mahdi Arghavani <ma.arghavani@yahoo.=
com> wrote:
>
> Dear Eric and Neal,
>
> Thank you for the email.

Please use plain text email so that your emails will be forwarded by
the netdev mail server. :-)

> >>> Am I right to say you are referring to
> commit 8165a96f6b7122f25bf809aecf06f17b0ec37b58
>
> Yes. The issue arises as a side effect of the changes introduced in this =
commit.
>
> >>> Please provide a packetdrill test, this will be the most efficient wa=
y to demonstrate the issue.
>
> Below are two different methods of demonstrating the issue:
> A) Demonstrating via the source code
> The changes introduced in commit 8165a9 move the caller of the `bictcp_hy=
start_reset` function inside the `hystart_update` function.
> This modification adds an additional condition for triggering the caller,=
 requiring that (tcp_snd_cwnd(tp) >=3D hystart_low_window) must also be sat=
isfied before invoking `bictcp_hystart_reset`.

Thanks for the nice analysis.

Looks like 8165a96f6b7122f25bf809aecf06f17b0ec37b58=C2=A0 is a stable
branch fix, and the original commit is:
4e1fddc98d2585ddd4792b5e44433dcee7ece001

So the ultimate patch to fix this can use a Fixes tag like:

Fixes: 4e1fddc98d25 ("tcp_cubic: fix spurious Hystart ACK train
detections for not-cwnd-limited flows")

Please also move the "hystart triggers when cwnd is larger than some
threshold" comment to the line above where you have moved the logic:

So the patch reads something like:

@@ -392,6 +392,9 @@ static void hystart_update(struct sock *sk, u32 delay)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (after(tp->snd_una, ca->end_seq))
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bictcp_hystart_rese=
t(sk);

+=C2=A0 =C2=A0 =C2=A0 /* hystart triggers when cwnd is larger than some thr=
eshold */
+=C2=A0 =C2=A0 =C2=A0 if (tcp_snd_cwnd(tp) < hystart_low_window)
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
+
...
-=C2=A0 =C2=A0 =C2=A0 /* hystart triggers when cwnd is larger than some thr=
eshold */
-=C2=A0 =C2=A0 =C2=A0 if (!ca->found && tcp_in_slow_start(tp) && hystart &&
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcp_snd_cwnd(tp) >=3D hystart_low_windo=
w)
+=C2=A0 =C2=A0 =C2=A0 if (!ca->found && tcp_in_slow_start(tp) && hystart)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hystart_update(sk, =
delay);
}

> B) Demonstrating via a test
> Unfortunately, I was unable to directly print the value of `ca->round_sta=
rt` (a variable defined in `tcp_cubic.c`) using packetdrill and provide you=
 with the requested script.
> Instead, I added a few lines of code to log the status of TCP variables u=
pon packet transmission and ACK reception.
> To reproduce the same output on your Linux system, you need to apply the =
changes I made to `tcp_cubic.c` and `tcp_output.c` (see the attached files)=
 and recompile the kernel.
> I used the attached packetdrill script "only" to emulate data transmissio=
n for the test.
> Below are the logs accumulated in kern.log after running the packetdrill =
script:
>
> In Line01, the start of the first round is marked by the cubictcp_init fu=
nction. However, the second round is marked by the reception of the 7th ACK=
 when cwnd is 16 (see Line20).
> This is incorrect because the 2nd round is started upon receiving the fir=
st ACK.
> This means that `ca->round_start` is updated at t=3D720994842, while it s=
hould have been updated 15.5 ms earlier, at t=3D720979320.
> In this test, the length of the ACK train in the second round is calculat=
ed to be 15.5 ms shorter, which renders one of HyStart's criteria ineffecti=
ve.
>
> Line01. 2025-01-08T08:16:23.321839+00:00 h1a kernel: New round is started=
. t=3D720873683 Sport=3D36895 cwnd=3D10 inflight=3D0 RTT=3D100300
> Line02. 2025-01-08T08:16:23.321842+00:00 h1a kernel: Pkt sending. t=3D720=
873878 Sport=3D36895 cwnd=3D10 inflight=3D0 RTT=3D100300 nextSeq=3D39151834=
79
> Line03. 2025-01-08T08:16:23.321845+00:00 h1a kernel: Pkt sending. t=3D720=
873896 Sport=3D36895 cwnd=3D10 inflight=3D2 RTT=3D100300 nextSeq=3D39151854=
79
> Line04. 2025-01-08T08:16:23.321847+00:00 h1a kernel: Pkt sending. t=3D720=
873896 Sport=3D36895 cwnd=3D10 inflight=3D4 RTT=3D100300 nextSeq=3D39151874=
79
> Line05. 2025-01-08T08:16:23.321849+00:00 h1a kernel: Pkt sending. t=3D720=
873896 Sport=3D36895 cwnd=3D10 inflight=3D6 RTT=3D100300 nextSeq=3D39151894=
79
> Line06. 2025-01-08T08:16:23.427777+00:00 h1a kernel: Pkt sending. t=3D720=
873896 Sport=3D36895 cwnd=3D10 inflight=3D8 RTT=3D100300 nextSeq=3D39151914=
79
> Line07. 2025-01-08T08:16:23.427787+00:00 h1a kernel: Ack receiving. t=3D7=
20979320 Sport=3D36895 cwnd=3D10 inflight=3D9 RTT=3D100942 acked=3D1
> Line08. 2025-01-08T08:16:23.427790+00:00 h1a kernel: Pkt sending. t=3D720=
979335 Sport=3D36895 cwnd=3D11 inflight=3D9 RTT=3D100942 nextSeq=3D39151934=
79
> Line09. 2025-01-08T08:16:23.427792+00:00 h1a kernel: Ack receiving. t=3D7=
20979421 Sport=3D36895 cwnd=3D11 inflight=3D10 RTT=3D101517 acked=3D1
> Line10. 2025-01-08T08:16:23.432773+00:00 h1a kernel: Pkt sending. t=3D720=
979431 Sport=3D36895 cwnd=3D12 inflight=3D10 RTT=3D101517 nextSeq=3D3915195=
479
> Line11. 2025-01-08T08:16:23.432785+00:00 h1a kernel: Ack receiving. t=3D7=
20984502 Sport=3D36895 cwnd=3D12 inflight=3D11 RTT=3D102654 acked=3D1
> Line12. 2025-01-08T08:16:23.432788+00:00 h1a kernel: Pkt sending. t=3D720=
984514 Sport=3D36895 cwnd=3D13 inflight=3D11 RTT=3D102654 nextSeq=3D3915197=
479
> Line13. 2025-01-08T08:16:23.432790+00:00 h1a kernel: Ack receiving. t=3D7=
20984585 Sport=3D36895 cwnd=3D13 inflight=3D12 RTT=3D103658 acked=3D1
> Line14. 2025-01-08T08:16:23.437774+00:00 h1a kernel: Pkt sending. t=3D720=
984594 Sport=3D36895 cwnd=3D14 inflight=3D12 RTT=3D103658 nextSeq=3D3915199=
479
> Line15. 2025-01-08T08:16:23.437783+00:00 h1a kernel: Ack receiving. t=3D7=
20989668 Sport=3D36895 cwnd=3D14 inflight=3D13 RTT=3D105172 acked=3D1
> Line16. 2025-01-08T08:16:23.437785+00:00 h1a kernel: Pkt sending. t=3D720=
989679 Sport=3D36895 cwnd=3D15 inflight=3D13 RTT=3D105172 nextSeq=3D3915201=
479
> Line17. 2025-01-08T08:16:23.437787+00:00 h1a kernel: Ack receiving. t=3D7=
20989747 Sport=3D36895 cwnd=3D15 inflight=3D14 RTT=3D106507 acked=3D1
> Line18. 2025-01-08T08:16:23.442773+00:00 h1a kernel: Pkt sending. t=3D720=
989757 Sport=3D36895 cwnd=3D16 inflight=3D14 RTT=3D106507 nextSeq=3D3915203=
479
> Line19. 2025-01-08T08:16:23.442780+00:00 h1a kernel: Ack receiving. t=3D7=
20994842 Sport=3D36895 cwnd=3D16 inflight=3D15 RTT=3D108312 acked=3D1
>
> Line20. 2025-01-08T08:16:23.442782+00:00 h1a kernel: New round is started=
. t=3D720994842 Sport=3D36895 cwnd=3D16 inflight=3D15 RTT=3D108312
>
> Line21. 2025-01-08T08:16:23.442783+00:00 h1a kernel: Pkt sending. t=3D720=
994857 Sport=3D36895 cwnd=3D17 inflight=3D15 RTT=3D108312 nextSeq=3D3915205=
479
> Line22. 2025-01-08T08:16:23.442785+00:00 h1a kernel: Ack receiving. t=3D7=
20994927 Sport=3D36895 cwnd=3D17 inflight=3D16 RTT=3D109902 acked=3D1
> Line23. 2025-01-08T08:16:23.448788+00:00 h1a kernel: Pkt sending. t=3D720=
994936 Sport=3D36895 cwnd=3D18 inflight=3D16 RTT=3D109902 nextSeq=3D3915207=
479
> Line24. 2025-01-08T08:16:23.448805+00:00 h1a kernel: Ack receiving. t=3D7=
21000016 Sport=3D36895 cwnd=3D18 inflight=3D17 RTT=3D111929 acked=3D1
> Line25. 2025-01-08T08:16:23.448807+00:00 h1a kernel: Pkt sending. t=3D721=
000026 Sport=3D36895 cwnd=3D19 inflight=3D17 RTT=3D111929 nextSeq=3D3915209=
479
> Line26. 2025-01-08T08:16:23.448808+00:00 h1a kernel: Ack receiving. t=3D7=
21000100 Sport=3D36895 cwnd=3D19 inflight=3D18 RTT=3D113713 acked=3D1
> Line27. 2025-01-08T08:16:23.496807+00:00 h1a kernel: Pkt sending. t=3D721=
000110 Sport=3D36895 cwnd=3D20 inflight=3D18 RTT=3D113713 nextSeq=3D3915211=
479

To create a packetdrill test, you don't need to print round_start. You
can simply construct a packetdrill scenario and assert that
tcpi_snd_cwnd and tcpi_snd_ssthresh change in the expected ways over
the course of the test, as packetdrill injects ACKs into your kernel
under test.

I have upstreamed our packetdrill tests for TCP CUBIC today, so you
can have some examples to look at. I recommend looking at the
gtests/net/tcp/cubic/cubic-hystart-delay-rtt-jumps-upward.pkt file in
this patch:

https://github.com/google/packetdrill/commit/8d63bbc7d6273f86e826ac16dbc3c3=
8d4a41b129#diff-d7a68a37bc59309d374f8b97abcd406e263980415dd5af5c68db23f90f2=
d21a6

Before sending your patch to the list, please:

+ Download and build packetdrill. For tips on using packetdrill, you
can start with:

https://github.com/google/packetdrill

+ run all cubic packetdrill tests, to help test that your commit does
not introduce any bugs:

cd ~/packetdrill/gtests/net/
./packetdrill/run_all.py -S -v -L -l tcp/cubic/

+ read: https://www.kernel.org/doc/html/v6.11/process/maintainer-netdev.htm=
l

+ run something like the following to verify the format of the patch

git format-patch --subject-prefix=3D'PATCH net' HEAD~1..HEAD
./scripts/checkpatch.pl 00*patch

When all the warnings have been resolved, you can send the patch to
the list. :-)

> >>> Note that we are still waiting for an HyStart++ implementation for li=
nux, you may be interested in working on it.
>
> Thank you for the suggestion. I would be happy to work on the HyStart++ i=
mplementation for Linux. Could you kindly provide more details on the speci=
fic requirements, workflow, and expected outcomes to help me get started?

The specific requirements are in the Hystart++ RFC:
=C2=A0 https://datatracker.ietf.org/doc/html/rfc9406

The workflow would be to develop the code, run your kernel to test it
with packetdrill and test transfers in a controlled setting, then send
the patches to the netdev list for review.

The expected outcome would be to come up with working patches that are
readable, pass ./scripts/checkpatch.pl, compile and pass packetdrill
cubic tests, and produce improved behavior in at least some test
(probably a test where the Hystart++ implementation prevents a
spurious exit of slow-start when min_rtt jumps upward, which is common
in cellular/wifi cases).

thanks,
neal


> Best wishes,
> Mahdi Arghavani
>
> On Monday, January 6, 2025 at 09:24:49 PM GMT+13, Eric Dumazet <edumazet@=
google.com> wrote:
>
>
> On Mon, Jan 6, 2025 at 5:53=E2=80=AFAM Mahdi Arghavani <ma.arghavani@yaho=
o.com> wrote:
> >
> > Hi,
> >
> > While refining the source code for our project (SUSS), I discovered a b=
ug in the implementation of HyStart in the Linux kernel, starting from vers=
ion v5.15.6. The issue, caused by incorrect marking of round starts, result=
s in inaccurate measurement of the length of each ACK train. Since HyStart =
relies on the length of ACK trains as one of two key criteria to stop expon=
ential cwnd growth during Slow-Start, this inaccuracy renders the criterion=
 ineffective, potentially degrading TCP performance.
> >
>
> Hi Mahdi
>
> netdev@ mailing list does not accept HTML messages.
>
> Am I right to say you are referring to
>
> commit 8165a96f6b7122f25bf809aecf06f17b0ec37b58
> Author: Eric Dumazet <edumazet@google.com>
> Date:=C2=A0 Tue Nov 23 12:25:35 2021 -0800
>
>=C2=A0 =C2=A0 tcp_cubic: fix spurious Hystart ACK train detections for
> not-cwnd-limited flows
>
>=C2=A0 =C2=A0 [ Upstream commit 4e1fddc98d2585ddd4792b5e44433dcee7ece001 ]
>
>
>
> > Issue Description: The problem arises because the hystart_reset functio=
n is not called upon receiving the first ACK (when cwnd=3Diw=3D10, see the =
attached figure). Instead, its invocation is delayed until the condition cw=
nd >=3D hystart_low_window is satisfied. In each round, this delay causes:
> >
> > 1) A postponed marking of the start of a new round.
> >
> > 2) An incorrect update of ca->end_seq, leading to incorrect marking of =
the subsequent round.
> >
> > As a result, the ACK train length is underestimated, which adversely af=
fects HyStart=E2=80=99s first criterion for stopping cwnd exponential growt=
h.
> >
> > Proposed Solution: Below is a tested patch that addresses the issue by =
ensuring hystart_reset is triggered appropriately:
> >
>
>
>
> Please provide a packetdrill test, this will be the most efficient way
> to demonstrate the issue.
>
> In general, ACK trains detection is not useful in modern networks,
> because of TSO and GRO.
>
> Reference : https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/commit/?id=3Dede656e8465839530c3287c7f54adf75dc2b9563
>
> Note that we are still waiting for an HyStart++ implementation for linux,
> you may be interested in working on it.
>
> Thank you.
>
>
> >
> >
> > diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
> >
> > index 5dbed91c6178..78d9cf493ace 100644
> >
> > --- a/net/ipv4/tcp_cubic.c
> >
> > +++ b/net/ipv4/tcp_cubic.c
> >
> > @@ -392,6 +392,9 @@ static void hystart_update(struct sock *sk, u32 del=
ay)
> >
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (after(tp->snd_una, ca->end_seq))
> >
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bictcp_hystart_r=
eset(sk);
> >
> >
> >
> > +=C2=A0 =C2=A0 =C2=A0 if (tcp_snd_cwnd(tp) < hystart_low_window)
> >
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> >
> > +
> >
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (hystart_detect & HYSTART_ACK_TRAIN) {
> >
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 now =3D bict=
cp_clock_us(sk);
> >
> >
> >
> > @@ -468,8 +471,7 @@ __bpf_kfunc static void cubictcp_acked(struct sock =
*sk, const struct ack_sample
> >
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ca->delay_min =
=3D delay;
> >
> >
> >
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* hystart triggers when cwnd is larger than=
 some threshold */
> >
> > -=C2=A0 =C2=A0 =C2=A0 if (!ca->found && tcp_in_slow_start(tp) && hystar=
t &&
> >
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcp_snd_cwnd(tp) >=3D hystart_low_w=
indow)
> >
> > +=C2=A0 =C2=A0 =C2=A0 if (!ca->found && tcp_in_slow_start(tp) && hystar=
t)
> >
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hystart_update(s=
k, delay);
> >
> >=C2=A0 }
> >
> > Best wishes,
> > Mahdi Arghavani

------=_Part_6961053_754585562.1736660842181
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="cubic-hystart-length-of-ack-train.pkt"
Content-ID: <a98ed21d-3945-0ce7-94b4-c0da5b6e9f10@yahoo.com>

Ly8gVGVzdCBvZiB0aGUgQ1VCSUMgSFlTVEFSVF9BQ0tfVFJBSU4gbWVjaGFuaXNtLgovLyBWZXJp
ZnkgdGhhdCBpdCBjb3JyZWN0bHkgZXhpdHMgc2xvdyBzdGFydCBpZiB0aGUgbGVuZ3RoIG9mCi8v
IEFDSyB0cmFpbiA+IGhhbGYgb2YgdGhlIGNvbm5lY3Rpb24ncyBtaW5fcnR0LgoKYC4uL2NvbW1v
bi9kZWZhdWx0cy5zaAojIFRvIG9ubHkgcmVseSBvbiBIWVNUQVJULUFDSy1UUkFJTiBkZXRlY3Rp
b24gbWVjaGFuaXNtOgplY2hvIDEgPiAvc3lzL21vZHVsZS90Y3BfY3ViaWMvcGFyYW1ldGVycy9o
eXN0YXJ0X2RldGVjdApgCgogICAgMCBzb2NrZXQoLi4uLCBTT0NLX1NUUkVBTSwgSVBQUk9UT19U
Q1ApID0gMwogICArMCBzZXRzb2Nrb3B0KDMsIFNPTF9TT0NLRVQsIFNPX1JFVVNFQUREUiwgWzFd
LCA0KSA9IDAKICAgKzAgYmluZCgzLCAuLi4sIC4uLikgPSAwCiAgICswIGxpc3RlbigzLCAxKSA9
IDAKCiAgICswIDwgUyAwOjAoMCkgd2luIDMyNzkyIDxtc3MgMTAwMCxzYWNrT0ssbm9wLG5vcCxu
b3Asd3NjYWxlIDc+CiAgICswID4gUy4gMDowKDApIGFjayAxIDxtc3MgMTQ2MCxub3Asbm9wLHNh
Y2tPSyxub3Asd3NjYWxlIDg+CisuMDMwIDwgLiAxOjEoMCkgYWNrIDEgd2luIDI1NwogICArMCBh
Y2NlcHQoMywgLi4uLCAuLi4pID0gNAogICArMCBzZXRzb2Nrb3B0KDQsIFNPTF9TT0NLRVQsIFNP
X1NOREJVRiwgWzIwMDAwMF0sIDQpID0gMAoKICAgKzAgJXsgVENQX0lORklOSVRFX1NTVEhSRVNI
ID0gMHg3ZmZmZmZmZiB9JQoKICAgKzAgd3JpdGUoNCwgLi4uLCAzMDAwMCkgPSAzMDAwMAogICAr
MCA+IFAuIDE6MTAwMDEoMTAwMDApIGFjayAxCiAgICswICV7IGFzc2VydCB0Y3BpX3NuZF9jd25k
ID09IDEwLCB0Y3BpX3NuZF9jd25kIH0lCgorLjAzMCA8IC4gMToxKDApIGFjayAxMDAxIHdpbiAy
NTcKKy4wMDEgPCAuIDE6MSgwKSBhY2sgMjAwMSB3aW4gMjU3CisuMDAxIDwgLiAxOjEoMCkgYWNr
IDMwMDEgd2luIDI1NworLjAwMSA8IC4gMToxKDApIGFjayA0MDAxIHdpbiAyNTcKKy4wMDEgPCAu
IDE6MSgwKSBhY2sgNTAwMSB3aW4gMjU3CisuMDAxIDwgLiAxOjEoMCkgYWNrIDYwMDEgd2luIDI1
NworLjAwMSA8IC4gMToxKDApIGFjayA3MDAxIHdpbiAyNTcKKy4wMDEgPCAuIDE6MSgwKSBhY2sg
ODAwMSB3aW4gMjU3CisuMDAxIDwgLiAxOjEoMCkgYWNrIDkwMDEgd2luIDI1NworLjAwMSA8IC4g
MToxKDApIGFjayAxMDAwMSB3aW4gMjU3CgogICArMCA+IFAuIDEwMDAxOjMwMDAxKDIwMDAwKSBh
Y2sgMQogICArMCAleyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9PSAyMCwgdGNwaV9zbmRfY3duZCB9
JQoKKy4wMzAgPCAuIDE6MSgwKSBhY2sgMTEwMDEgd2luIDI1NwogICArMCAleyBhc3NlcnQgdGNw
aV9zbmRfY3duZCA9PSAyMSwgdGNwaV9zbmRfY3duZCB9JQoKKy4wMDEgPCAuIDE6MSgwKSBhY2sg
MTIwMDEgd2luIDI1NwogICArMCAleyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9PSAyMiwgdGNwaV9z
bmRfY3duZCB9JQoKKy4wMDEgPCAuIDE6MSgwKSBhY2sgMTMwMDEgd2luIDI1NwogICArMCAleyBh
c3NlcnQgdGNwaV9zbmRfY3duZCA9PSAyMywgdGNwaV9zbmRfY3duZCB9JQoKKy4wMDEgPCAuIDE6
MSgwKSBhY2sgMTQwMDEgd2luIDI1NwogICArMCAleyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9PSAy
NCwgdGNwaV9zbmRfY3duZCB9JQoKKy4wMDEgPCAuIDE6MSgwKSBhY2sgMTUwMDEgd2luIDI1Nwog
ICArMCAleyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9PSAyNSwgdGNwaV9zbmRfY3duZCB9JQoKKy4w
MDEgPCAuIDE6MSgwKSBhY2sgMTYwMDEgd2luIDI1NwogICArMCAleyBhc3NlcnQgdGNwaV9zbmRf
Y3duZCA9PSAyNiwgdGNwaV9zbmRfY3duZCB9JQoKKy4wMDEgPCAuIDE6MSgwKSBhY2sgMTcwMDEg
d2luIDI1NwogICArMCAleyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9PSAyNywgdGNwaV9zbmRfY3du
ZCB9JQoKKy4wMDEgPCAuIDE6MSgwKSBhY2sgMTgwMDEgd2luIDI1NwogICArMCAleyBhc3NlcnQg
dGNwaV9zbmRfY3duZCA9PSAyOCwgdGNwaV9zbmRfY3duZCB9JQoKKy4wMDEgPCAuIDE6MSgwKSBh
Y2sgMTkwMDEgd2luIDI1NwogICArMCAleyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9PSAyOSwgdGNw
aV9zbmRfY3duZCB9JQoKKy4wMDEgPCAuIDE6MSgwKSBhY2sgMjAwMDEgd2luIDI1NwogICArMCAl
eyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9PSAzMCwgdGNwaV9zbmRfY3duZCB9JQoKKy4wMDEgPCAu
IDE6MSgwKSBhY2sgMjEwMDEgd2luIDI1NwogICArMCAleyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9
PSAzMSwgdGNwaV9zbmRfY3duZCB9JQoKKy4wMDEgPCAuIDE6MSgwKSBhY2sgMjIwMDEgd2luIDI1
NwogICArMCAleyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9PSAzMiwgdGNwaV9zbmRfY3duZCB9JQoK
Ky4wMDEgPCAuIDE6MSgwKSBhY2sgMjMwMDEgd2luIDI1NwogICArMCAleyBhc3NlcnQgdGNwaV9z
bmRfY3duZCA9PSAzMywgdGNwaV9zbmRfY3duZCB9JQoKKy4wMDEgPCAuIDE6MSgwKSBhY2sgMjQw
MDEgd2luIDI1NwogICArMCAleyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9PSAzNCwgdGNwaV9zbmRf
Y3duZCB9JQoKKy4wMDEgPCAuIDE6MSgwKSBhY2sgMjUwMDEgd2luIDI1NwogICArMCAleyBhc3Nl
cnQgdGNwaV9zbmRfY3duZCA9PSAzNSwgdGNwaV9zbmRfY3duZCB9JQoKKy4wMDEgPCAuIDE6MSgw
KSBhY2sgMjYwMDEgd2luIDI1NwogICArMCAleyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9PSAzNiwg
dGNwaV9zbmRfY3duZCB9JQoKKy4wMDEgPCAuIDE6MSgwKSBhY2sgMjcwMDEgd2luIDI1NwovLyBI
eXN0YXJ0IGV4aXRzIHNsb3cgc3RhcnQgaGVyZSBhdCBhIGN3bmQgb2YgMzY6CiAgICswICV7IHBy
aW50KHRjcGlfc25kX2N3bmQpOyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9PSAzNiwgdGNwaV9zbmRf
Y3duZCB9JQogICArMCAleyBhc3NlcnQgdGNwaV9zbmRfc3N0aHJlc2ggIT0gVENQX0lORklOSVRF
X1NTVEhSRVNILCB0Y3BpX3NuZF9zc3RocmVzaCB9JQoKKy4wMDEgPCAuIDE6MSgwKSBhY2sgMjgw
MDEgd2luIDI1NwogICArMCAleyBhc3NlcnQgdGNwaV9zbmRfc3N0aHJlc2ggIT0gVENQX0lORklO
SVRFX1NTVEhSRVNILCB0Y3BpX3NuZF9zc3RocmVzaCB9JQoKKy4wMDEgPCAuIDE6MSgwKSBhY2sg
MjkwMDEgd2luIDI1NwogICArMCAleyBhc3NlcnQgdGNwaV9zbmRfc3N0aHJlc2ggIT0gVENQX0lO
RklOSVRFX1NTVEhSRVNILCB0Y3BpX3NuZF9zc3RocmVzaCB9JQoKKy4wMDEgPCAuIDE6MSgwKSBh
Y2sgMzAwMDEgd2luIDI1NwogICArMCAleyBhc3NlcnQgdGNwaV9zbmRfc3N0aHJlc2ggIT0gVENQ
X0lORklOSVRFX1NTVEhSRVNILCB0Y3BpX3NuZF9zc3RocmVzaCB9JQo=

------=_Part_6961053_754585562.1736660842181--

