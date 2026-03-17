Return-Path: <netdev+bounces-268650-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIAMCPZvuWm8EgIAu9opvQ
	(envelope-from <netdev+bounces-268650-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:15:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAF32ACC73
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD56D304D178
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0ADF3E9F82;
	Tue, 17 Mar 2026 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkCMC06X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729DB3EAC6F
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773760164; cv=pass; b=dfkqjd7uZCmukZcwTc0+LKukM+ZAeZ2UdbYiPVTgf/OyFdfDIVsHvdNJVajkoSn29JVff/rc2UZtgSn1eYcMiLBjy+3IN+2i3cVnE0TDdlBD+GUoItrauTvUFMHtzTiADoIV0OJxGfwlsovBFVjAMKmhTHpF9BYn7Y0ZNZorTmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773760164; c=relaxed/simple;
	bh=+/eTKpmJOSgu7uffITQOtlY4zUFjR+8w8SAVqozHIXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmDeMEzmidkfK1+MRPpBrOZ/5eh9bayZFwdzg6fJGXXiQeQFKVk8Eu0tZrfrez+MXOVoh4xAY69VBSC3cq4U4g2lIVTzja6PqrNfEAvp2s4O6gmIpE/d1Ssb384QoelXyVnwd3NbtUE5aTpMOOgOFx7lT+IPkw2erRZTSgf9pUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkCMC06X; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439cd6b09f8so4605971f8f.3
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 08:09:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773760160; cv=none;
        d=google.com; s=arc-20240605;
        b=Yl2JemUZzNNyC0jPj3gw8J4LcOcInXW/LMkg+PMuvPpLb8CKkPrFNDoOKkI0DfbYuW
         ymtXmNl/hCOjyYn7OIwa2vI/S5bHiKt9M5PRmiOq6TEry+L8pxP1AP+N0CsacARvWsvV
         bCzmwRNrKBvpG0v1eSvnHB/l2kLron3shzLGjYn0sWEAlhufQ/DvfPHqy4kOJvQ5wt22
         anLvHFb7po093tcuF0Pz22PR9R9LqdjliLgWCKFs/yQrQk1GUQ4osJEtMRkdaKDLOo06
         WWtJaJmSQv0iGfiM3TGhwQP/bkuOwu+eyam9ZZYrnDpQ/NCeDggNQwjCMx4UvANDYf3T
         Kc0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+/eTKpmJOSgu7uffITQOtlY4zUFjR+8w8SAVqozHIXg=;
        fh=ROykOQ6OpKcf6l9vsOhzawFmAqf7/MaeYBmQmdP8Mrg=;
        b=bQMuJJCw04zMmuQu2DvzF+oMhrorpVfajxG/J4qqwaf68OgDdayNjWyeWsxMcX53yn
         IOK+IfxO/n36wIpP+a8Dt6EEvdItHVQ5Fhd9EiAo5pCKgptZIQ8e7NPo0gyOlqwZHalD
         cDBRRqqf32efD9/02G3TS62Zr5VfiWSq+PythscqERYcK6pv3xgk805V2fq/RedgN3bQ
         S0y9OoqE/JFvrDN0VjRUJ9ww4ewiUpRUt6BHGIsiUPlaCv964GwyKID3e0RlEjadPbhe
         AcwpNXLyMtyI9LEkSkuw9Rh6DJUjvpEHKkP7VY8BfWD8XME15/SLQtVlIFUbQOhUgMML
         RwBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773760160; x=1774364960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/eTKpmJOSgu7uffITQOtlY4zUFjR+8w8SAVqozHIXg=;
        b=IkCMC06XggcU8j5IpH2JWi3OmI4cfDKeNxU56vHeqxA2HIC0Z3L7WWIWnq3NF9iqby
         i2Y66QgF45XLP8rFFBECYfbrvb3S11mCH0rigo49pEQ9U8fL+WsVu5Jwd6kfHzWc0vnP
         Ezott5KYBuYFLDujmrcdiwsNPkNRv9q0A33UO5eQZXbVVP1zQSL2QDefKjZaQVn1lcVY
         esNqP5ewRdxllm1mVYfETqOrfe0Si9uMtlne9Ev58ZqPdO9Y55Ap6VxreklonP/6EXJD
         duQ0C1kjsAPeXYwLKt4uMJx1UiXGTsH/0kt0dm3Fz2O26S2kpIL20whmHZNqXiL+AYoj
         xe8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773760160; x=1774364960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+/eTKpmJOSgu7uffITQOtlY4zUFjR+8w8SAVqozHIXg=;
        b=I8ywRLtwtKkeB+mYStKosX/Ov29fR0p95ZNpUJDUrLO8KYWOGZMxTNBjIC4S7BOeEt
         hK9WE+BKGYB0H908qpx9ZwNf4swq+IRkQ1YPf2+lYHj9XivEn2+Z+dWVa5n6jciaMLUz
         /pnpemkwt+IgISLZ1C9Kxt04q3fqeNiJ6cuSkHSkErSS8lD95ZOhRU9M1nzHkB7IjagS
         2w8LlP7lgXI9g6/04nO6F7r2UK7bO17UF+QlQAJYY09IJhXY7LZhT2dw3WOev2X2TUiY
         F7qBrm3xL1icdw7PUJCbS38K7yosS5cAnzifNPwVDQnCLJtpsBkzCrPcWJd32ddkm3tW
         eGhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXR8davLgwziTghBj+qJvtAebdNsvev1QBiLIqovooW4c4j/96jiUeQbJ2NNQufwR2iQ2OeAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxSAPbWGtni1nY2UjB0HJ8b8NlItn5S0aYk/A/+5/l9GiJ2Nai
	+ljOTaLlL5wFut90+FbvGQrnaUZqh3Yf8fAB6TdTKyjV18Ee1H3m1KYRVPsrLOh8FE9UmdpMEuM
	1yeO63thEljUNLEbZ50BIGR3MOmx4c7k=
X-Gm-Gg: ATEYQzxrYHjXU/CBFEfJc78/I9+5PoyOOzFbKniU6ebUUHZjOWr9EaRm71QtoP21gVO
	t667XiwlzpjEuQNLAL8WmFOnU4OGIuzIRj2cx3S/b97slKzqkBdiWPzLddohJQ702MqQBvqUDBC
	oExiqqZLWCuFupO+4YIrWhPqI6T6JhzpiOG/+2cROnS1x70NEqKt/0TEVupYyOsTHtR6yJdmE+5
	k7P9MCSa1vaUrp7+xcJz9jz7XY5GSRwPABFugCuEzbdeYLHL+4nsIb08V8JLnMd4nhj7xttQQnB
	nn4SENV4Q+uCmoowG85MdC+DgsHbTXbs6NmzkfV2vGvwtrCbc6bwMQqq5DyqFFdPIpM=
X-Received: by 2002:a05:6000:4013:b0:43b:3de5:611a with SMTP id
 ffacd0b85a97d-43b3de562ccmr17523497f8f.12.1773760160136; Tue, 17 Mar 2026
 08:09:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316140557.461288-1-maciej.fijalkowski@intel.com> <20260316171200.4b8a96a0@kernel.org>
In-Reply-To: <20260316171200.4b8a96a0@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Mar 2026 08:09:08 -0700
X-Gm-Features: AaiRm51ZeW7_QL0pHZ4m-XU4Rn2lnA0V7NNVacbUTn3HGON1-B9xtWziG8dAs8s
Message-ID: <CAADnVQJ=nryHHb5A3r77H6dzg=vzC97eHe8mCeBA=BMxa=+P5Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] xsk: use __xsk_rcv_zc_safe for ZC
 multi-buffer Rx processing
To: Jakub Kicinski <kuba@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, "Karlsson, Magnus" <magnus.karlsson@intel.com>, 
	Stanislav Fomichev <stfomichev@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268650-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,gmail.com,redhat.com,kernel.org,iogearbox.net];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8EAF32ACC73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 5:12=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 16 Mar 2026 15:05:57 +0100 Maciej Fijalkowski wrote:
> > Commit f620af11c27b ("xsk: avoid double checking against rx queue being
> > full") addressed a case in copy mode, when working with multi-buffer
> > xdp_buff, where we were peeking onto XSK Rx queue twice, to find out if
> > there is a space to produce descriptors.
> >
> > Adjust ZC path to follow the same principle.
>
> Acked-by: Jakub Kicinski <kuba@kernel.org>

Do you guys need it in net-next in this merge window ?

We have nothing in bpf-next/net so far, so should be fine
to take this patch into net-next directly?

Martin, thoughts?

