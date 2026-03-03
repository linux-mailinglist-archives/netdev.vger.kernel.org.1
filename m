Return-Path: <netdev+bounces-263422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAkrDFRRp2nKggAAu9opvQ
	(envelope-from <netdev+bounces-263422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:23:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FF31F7759
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEB113013A73
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 21:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303CF38C2DD;
	Tue,  3 Mar 2026 21:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1I12xVRm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED2332AAD1
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 21:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572722; cv=pass; b=IhLU0sGxgbtYW5s1avPE2S2B3pbAJ+Rq8kNnQnHdXw+DlCeO/qT8ZpRxM1tkT1AFJQQ3KlSByu3DipfvTGyJFMtQDaNhhptoWsYw+0+wZM83Po8feuYjO3L7joKGJ7jbpmGZjslIvlpTafWLEeD9PMxz9QXrBEdaHmeCTS63gVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572722; c=relaxed/simple;
	bh=kqBekaqTLUTuIqVLl/Xn32stOU/skKJREqaiqK/UiSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNkagcQWAImTvU3gaL1CWN5iUR/RJ+49N/CGY7xThvuqLgsogdpnrid5H8gWur3z7SmcZ3IrmRnUxGbdfF8D6z8pk8KXU3Mgs4zP7WHRDqZKMfKXkOJVH+VuXPdo+oHGAOcKP1Pcaz4GRahPoMhszRINSj1/TjB1axIHlp7fCQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1I12xVRm; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1273349c56bso7474311c88.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 13:18:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772572720; cv=none;
        d=google.com; s=arc-20240605;
        b=Q4CgckNU0KdSIWnjMdgrnloTVOoZESissqLP52RN7fHVTs3SDly3F37cj5I2vV5vxo
         sp1640Ea8Y1+PCDQjCZPNig3Lt+JOalizDz+nlsTKRrB6Oo93tpB5cz426vownMEhcK/
         JPqdMw/PrwAQU+5w9wWMYrSDnpmRwvdTTUnSbN+b4Mx4Ch0w7ufxMLGzYvAdO2+yAXfg
         y9j2hgCD3YL6LGhUZCwfvtbQ6R2qdba2oFN+j1LPFZTA3Ve9BUtxL9uXe3vK+VvzV8Jv
         2mgVg/lQZboKGcOYPujObEYuxyZQPeldAPTuVJQfG8HJYvyBBZG8xf9pDmhQTBXwQDzS
         DwDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kqBekaqTLUTuIqVLl/Xn32stOU/skKJREqaiqK/UiSk=;
        fh=ktmI7hFceuhXePnl4dWcEZcMra6tLg/XBb6PPrxxW8Q=;
        b=HGBjqriBGI2kapzb+y39etsfDgMjxIde8eXjH/wsdnE7l16Z+3YnfbMUH+boroz7EQ
         QLlvHC19gdM6p8k09zAn/SwF3jh+cKZ2vHUcQr4g4tmBaPotbr5yd8CV65fGEffBShOX
         yDCsR6Y8znxix9O6xAR4QaYyolqgtrn302UcRZKuzQ8CkMHmJv0FKLQa0Rvrz2tL+74P
         Xjk5AmL2PifpDhB98O6fEwzzppocIoFeP1UUzl782jjOeiPhBfvrlBmOu+MyOxg7iyWu
         ScBVSLrzFnU1Dz0iNaDFUNMLR4OTrD9L4u4tMU3deDATJBbz+Q9ylMbuf6LpQG8ynaRG
         cXkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772572720; x=1773177520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqBekaqTLUTuIqVLl/Xn32stOU/skKJREqaiqK/UiSk=;
        b=1I12xVRmn9uobgGaWVjr9pwNSbKzIKJdprYqNuuPOWwmJ0FRvmg9dxPWqjnl+rJaZu
         Zq1trqIDdyLl1qt6N9zdQiBESsoBD5BhsMntKLIgt2G+LrmTehl2Opu1LoW/YeEMPtr/
         szYM408h1lxFhK46Ydg75MmVd8DX6HugvDgt6M/eWlfMWAJ9C1bEnduKaoy99nXWJiVk
         EHlNVduPZQAiHlsOUYL0fL1FYp0CumscV6f+Y6u9ATv13fWW9JqSdVMjLF/Ap+i8KfYC
         4zaiD4j0WtDkVJpdZE8dAXoww6YhBiRMRQ/0YScHz09mK8SuUxobl67S95ZtmJUz+QxO
         ++mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772572720; x=1773177520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kqBekaqTLUTuIqVLl/Xn32stOU/skKJREqaiqK/UiSk=;
        b=fngVKEnLpQtblLmmyYkP3Lp8DsEs6pXyj+uXoejashhF53CGochD/J8XNL0dr0wnD/
         V8sHZzCtV2bF9jL4pMtr78rvD7Mbw8KQX3s11DP3gntfyOdVIWMMZ/wTT1EQpCAK5Loj
         Nz6hSM8487NJZcq/93SLjjDvJtTXpU1qcH4MyKoLriwoaK23gxQIrs56IwMp/U/wiNAD
         04VW108wX/HjtGiQno4MG6HOCsXMVM0t5BjeZMrtfrPmx4MszuFXoCHPw/B/12ji8LZh
         cQESrV3LiQT2pC/ZhQ+afBZFodoMnRgJYkHJIFVYr4B2K11T4nu0ImMlU5js+8H84cg7
         Zy6w==
X-Gm-Message-State: AOJu0YxXqqFnPTWoIOCafzdYLLfOpsldBYDPIxhdVwZWxAJNB3g2lOCn
	SXx4fK7HK9YA5Pp2u/hehPmWgFLGRFjiFp8hTcYp4xtErFhC1yWipFYVVMhx9CCfGaUqj3KBPOj
	V3V8gtKxnaKc1caOq8fPUxE90ziwStbHeMl/QUR30
X-Gm-Gg: ATEYQzzszi7nZh5tD44bTIAfNQiN6UOuP61pm3QXeTad2dx8vROck/MvwFqcUDAPJXW
	W20xkkM8Sk/nUst2zjaEFGElSO2GT4g+O4t/57k2pUDALIbvpeUP79gMvqLhj6/MjKMIeEGqfKu
	srNtk5VBaity1QpimdipNbuw3GdUKIPjs1BGVICzWNtMN3WUTWvuRNrTsVtZ/EV6Dft5dme1yQx
	W2H5s8myiv6HkpCgWImP3J5MtndlFSWuKuPLgvHiNtOc84dUNjxUAjSZX/aKCFe5lurd3t3AE52
	h6PL+q7kiGHY9iGbUk6G5gSnwmcvjIAdMaAz0PzFDUDoNhiuIumJJpnhbUTHySeg7gxm8A==
X-Received: by 2002:a05:7022:20e:b0:127:5c57:cffc with SMTP id
 a92af1059eb24-1278fc1f980mr5546302c88.26.1772572719385; Tue, 03 Mar 2026
 13:18:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303172949.4741-1-fmancera@suse.de>
In-Reply-To: <20260303172949.4741-1-fmancera@suse.de>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 3 Mar 2026 13:18:28 -0800
X-Gm-Features: AaiRm50uYKOI7nxXxDuzBrnNN3EjwAriC15_wrOdsD4-O8mxMJY_UZ265TaI5So
Message-ID: <CAAVpQUChu=Wr91kjQz9cWzFmJwrWXz-SsLoD75J3prEKswE43g@mail.gmail.com>
Subject: Re: [PATCH net-next v3] inet: add ip_local_port_step_width sysctl to
 improve port usage distribution
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chia-yu.chang@nokia-bell-labs.com, 
	idosch@nvidia.com, willemb@google.com, dsahern@kernel.org, 
	ncardwell@google.com, skhan@linuxfoundation.org, corbet@lwn.net, 
	horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, 
	davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 86FF31F7759
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263422-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:email,mail.gmail.com:mid,0xffsoftware.com:url]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 9:30=E2=80=AFAM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
> With the current port selection algorithm, ports after a reserved port
> range or long time used port are used more often than others [1]. This
> causes an uneven port usage distribution. This combines with cloud
> environments blocking connections between the application server and the
> database server if there was a previous connection with the same source
> port, leading to connectivity problems between applications on cloud
> environments.
>
> The real issue here is that these firewalls cannot cope with
> standards-compliant port reuse. This is a workaround for such situations
> and an improvement on the distribution of ports selected.
>
> The proposed solution is to implement a variant of RFC 6056 Algorithm 5.
> The step size is selected randomly on every connect() call ensuring it
> is a coprime with respect to the size of the range of ports we want to
> scan. This way, we can ensure that all ports within the range are
> scanned before returning an error. To enable this algorithm, the user
> must configure the new sysctl option "net.ipv4.ip_local_port_step_width".
>
> In addition, on graphs generated we can observe that the distribution of
> source ports is more even with the proposed approach. [2]
>
> [1] https://0xffsoftware.com/port_graph_current_alg.html
>
> [2] https://0xffsoftware.com/port_graph_random_step_alg.html
>
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

