Return-Path: <netdev+bounces-289993-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMY6BYvSDWpP3gUAu9opvQ
	(envelope-from <netdev+bounces-289993-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:26:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EF0590C67
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE8A03060AAA
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 15:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DD63F1654;
	Wed, 20 May 2026 15:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxjVXlqU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC373F0765
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290346; cv=pass; b=ilKOvGSq7wUx7p1Qh8XTdZE/y896RZKGpX6FMuG2Dkr+qTwV532+jpI7nVxqUSR+bOs1keu5I4pFo2aZRK4lCElAb//UimmnXgIUGPrwDj0aFlUWYJbMMWaxHzrJTiCmIpKIY42oYS1Jpnbqvqi+mptVMA1+xFXhMNQfCgt0lZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290346; c=relaxed/simple;
	bh=3bmrQLW6G7lq7eJL1fF05clBDrJYs7JUDV2nc47aEbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4yfasOAM6hSJK6ablAqRHPjT5w95AEl6UPLvC7ALLMmWpcaAES0w5bDcj0GTvDwLDbTmL4AAsDbgWxebYzc8SE5sp8Uluxtv5v9S+KExEx1h5C/gbFdl0Es8K3chXsG6J7t+ovAnU9Moyliz3G+Cq5SbUD1SdSaNnNfErjSbZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qxjVXlqU; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65e15fb394bso3652364d50.2
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 08:19:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779290344; cv=none;
        d=google.com; s=arc-20240605;
        b=MkzG5nFz42JcXMZT5h4wgfv+Ki0TOYMvpaLC0GzMul8UyzfiAuigt5HaVVs6cl5wX3
         w3BCChPbOYL4uctoa3Cirh6AJYr0xfzIMgBFGJVqDq6+O7sGys0vgwrvxG9WnTCUSncR
         I61+ETzJLpnD9DQfNw99jkp5KTJKjTfnAWheJP/dECHpYBeZLwxiGQn7huyOcuRNY2i6
         9AIsqPqmd63thYvrMjs3UDsmoDmYGILsKMN8vdq4XdnTQB9OfN7xNtlYE1NZbE56j4jn
         nl72x9yRZ6b4cAAmlkLLIoFaXdNJPTPBt5nKyxk0XxPenF8j/yHj5zQveJ65OPAdwZas
         Vpbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3bmrQLW6G7lq7eJL1fF05clBDrJYs7JUDV2nc47aEbw=;
        fh=8x3ZebClDCKzE6Pc53ILqRDv1ZPFtCEClJGQ4tW5ItM=;
        b=IVR1NrZNYOZ/2s/Iux/uSGmvjQXt4SyzD5UjL0Ew/AaVLbg3h9/bWhTd4bU40pbiye
         UgsTrnmjrTTIlJZ8K5b1PcDy0fLuN7ddczorSgRZ2iYko2FbN49k7mp7LAdWjnCBas31
         PDoSDEz/Jk65r6rq6piykVKe2iSniT3QcHQzL6t5jxZrCpfFB+yymK/wvYJgfQ2VWJTp
         XCy1HorTi2C0EySo5TvdOHLOdW9MdU/LOCdltkWjFN2IteNX8Ev4KOeTGMVAe8UQPBi+
         H6djX2fGFd1Z8+htUw79qIR+ocDn/NaBVAre0vWclKGtna6Ppfi9C1CmKOfzNJ3rZjti
         Alag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779290344; x=1779895144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bmrQLW6G7lq7eJL1fF05clBDrJYs7JUDV2nc47aEbw=;
        b=qxjVXlqUfdE03SRW71A2N06iP8qP5nLqeN6pprEDdnboEdVxgxQErzX37k47E8DT0q
         X5oXGoqhul/7ct506GVTNshptUrlIaciwMqm+bdopsNLktt1Viz5V2xTn1h/4+uQMOXD
         wEcaloOGdcmHRIljdy+jh+minQ271pk+h5FaTk86Q/xGaUHRRRKEuw4eXb/zjz2oBR+T
         pVAkqiVsSwixBdAMbIzlPFf1zp8M2LVxOLcdfpaSgBA6Vf3LnHbT7sb0+OyltHeDkOBU
         VYpLwUS9sm+j+KRiXhv040QJmZgnstR9XFZdp8yFggvx67Qg805i8UGet2AGwOLQ9nSA
         boLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779290344; x=1779895144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3bmrQLW6G7lq7eJL1fF05clBDrJYs7JUDV2nc47aEbw=;
        b=NO8VD91jjtQiz1r3RZBpqOAH3aobqtLmCtHwH7MssIv7QQ3eWMkxvcK+XsX5S6/0D6
         8zL8Sk1vW5G7XiyYRk3FnjsvAGJ0OyPf0b7he89q7a60isRdRR2ccY6HXpNY5R22QDvf
         wfX4Rrj68u7JxO+Ozrm1yCgxLZ2ngFB/ByiFIofVe6kJpFojN/ID7j4uude2RiPKsrSP
         U7jsSxq3LSFU9eVNpJQ/s5ZzIhiL8slIVp1GGky+YThmOOSUFOwnVAqrAEtZvI0SSv9x
         gN0emWzxLqVUjokZOALOIOVZ/cj+lEpA8d9DE1sy2y6YwtN3HV9BSOblL5qh7F4DrKUH
         YsqQ==
X-Forwarded-Encrypted: i=1; AFNElJ+bsry4+Q75aMBeFgmmn+oLcCgO9h/4kh9hhfDwiSPKQU/+9l+lzMZTOhtoERWf+pvIqYDTvng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzILPIdSqiOmPHvJ8ug+8CYUgyJ+O6SNPBE2gKyoYiaXa99LyBO
	6pqLrYLUa8DKFpEAD5s9o0olYmzFg0qtA3RNqJDUF/gC11zZQorHGqRJF9Tg5E2b7hIl3RwVZPo
	cHjWLCZZsNHpern/z1wmeZjqCqcnOLUg=
X-Gm-Gg: Acq92OEz2wsvvMXN21QGg7Nc+nR70rFp+OCQkD3skzYFERDmRNoPqQc1cGov7zeZ8Hi
	iAeauWf4tqOGvQm3Mg79njf4pxdWIpEaCVeAsc4t9TShDt3R8dSw9x0xHiEZheTA7S9wFMbQJw7
	2PP4n/FKNBKcoZW7or46OQIC8ITicb1zpdQCEdsuQjfBusJQRvN150xGQVEyKG2aGuOo2TpKufr
	6cCFGYNYdxvvbCHdcUsrcZSGsf3yMPvsg8dx1cH0Qc2zwEb6C5xs086W71ftxz7QHCxGWxVDPJk
	b6xYE7HObScVmcYCMBrIwHaDivAfAaykrVg+3IS/OkoH2ut2IRvllqR+/q+e5Jt1kn5hdwxGoJ+
	7NQ==
X-Received: by 2002:a05:690e:250b:20b0:651:92cb:7157 with SMTP id
 956f58d0204a3-65e227fb576mr19553117d50.36.1779290343944; Wed, 20 May 2026
 08:19:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520135034.1060859-1-michael.bommarito@gmail.com>
 <CABBYNZLLw=VFfjaF_TXA=5ZgDt7rw=XgUULoc4JudMpUBf_BWg@mail.gmail.com> <CAJJ9bXw9r2XHYMkmjbJ9XAiGEG3VEWK6bjKHbHgwJqnOBzTu9w@mail.gmail.com>
In-Reply-To: <CAJJ9bXw9r2XHYMkmjbJ9XAiGEG3VEWK6bjKHbHgwJqnOBzTu9w@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 May 2026 11:18:52 -0400
X-Gm-Features: AVHnY4KnSO7nh2Mxl3gO31RP70GuHBlFZ_lZE7u6YBzWgqLDOxXw38-nlAPr38I
Message-ID: <CABBYNZ+q1c+3Su_3_ib=zbVMD35tgwMGjdV3OwM5a3GXOq1aRg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289993-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: A3EF0590C67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Michael,

On Wed, May 20, 2026 at 10:13=E2=80=AFAM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> On Wed, May 20, 2026 at 10:00=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > Weird, does the AI come up with this? The id is actually _not_
> > important because the error code will essentially indicate that the
> > entire packet was rejected. Therefore, it doesn't matter if the id is
> > for a request or a response, it still needs rejection if it exceeds
> > the MTU, so this seems overengineered.
>
> Yes, and I debated this with Claude, but it convinced me that the
> lifted helpers were more idiomatic for the actual spec and bt system:
> "The identifier shall match the first request command in the L2CAP
> packet. If only responses are recognized, the packet shall be silently
> discarded."

This coming from the spec is priceless because silently discarding the
packets means the remote stack won't know the responses were
discarded, causing the stacks to go out of sync. We also shouldn't
process packets beyond the allowed MTU. Therefore, I strongly disagree
with the spec requiring an identifier on the reject, as this implies
that even if a custom MTU is set, the packet must still be processed
if it exceeds that MTU to find the first request command within it.

> So if we ever lifted or refactored the code, it would be abundantly
> clear/safe to reuse elsewhere.
>
> There is also much shorter version that just peeks skb->data[1] and
> exits early if not ident=3D0 if that's what you're going for.
>
> Just let me know what version you prefer.
>
> Thanks,
> Mike



--=20
Luiz Augusto von Dentz

