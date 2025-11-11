Return-Path: <netdev+bounces-237427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1987C4B3B4
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 03:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A87A18912D3
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 02:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133B2348867;
	Tue, 11 Nov 2025 02:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfjB0TpC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313A934846C
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 02:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762828882; cv=none; b=V6QmytaYwfPK76H9VHlK5vBsbo/HQb5I5w5x3q/0HS4zLmo6z15JFYRHVDVeCukqD3XWHW6zvazLz/dXwEamz+63/LXuVCNmUaExxM+YuBr6oIJuczt1LDWComfuxsSbTCFHNkkISrOHJr5njjNKRiLgd9d+GnY5ekl10lE5Yh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762828882; c=relaxed/simple;
	bh=j8POPbpxSpPL02DZDm+FAXFDTPUlIreAK08ihYfV5Ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KgLoyLf0ImNIYCiBE39af95CqABfezjflubVuzmcH2rcexbg44i9NBUDUMUgWw6GVL08RJWLnDY+7l5ETW6M9Uz9Og+gQb4PTeIeGfjnfKctycB66zEKVauDbJvOeANtOtJq4/XBsTvzEgAieKB4hlHib4u7zhPn4Lx+XsHe0JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfjB0TpC; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-429c7e438a8so3225336f8f.2
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 18:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762828878; x=1763433678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8POPbpxSpPL02DZDm+FAXFDTPUlIreAK08ihYfV5Ow=;
        b=hfjB0TpCEo3kYg32fFZRXiDrqBOPHYThtITRucPce04EEJWoONjsFKUNUzBq95diT7
         CfKhJtMwnQUpPZXpTtfyZc/32etUp2hn7fQve40uCOcuWqIZXHGFXzLKqrlT6qxZVvCL
         IL7hGx5ndeRMW6F9XkNPTsFoO3mvfuZaNdAYAR9e3ecb1mvaj/Mdst5I52cRHOpOq2uD
         JdCKWXCYtRcS3nukn0tP3kIvhEwONNpo0EJ8V2+d5Dpl0YBaCajptpp+pZiTZ8eFFg1t
         8puP+SUzVlM8Y6hzRVtnwMGnuusohkOSkR/Vt5lQLg7KlM4hD2HVazQ3jBiq24BYuOM5
         nXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762828878; x=1763433678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j8POPbpxSpPL02DZDm+FAXFDTPUlIreAK08ihYfV5Ow=;
        b=QVXDzTPwe37U1g5QoLML/J9cD57GZDxGq0kY9LgYty8GVNpeNInizmX0/853SXaVds
         vZp1jDeu0V7PNRorxq71w/ZzrCmWPh0bONEHdt+U/n0lO1X+6a2TjSqhJSJm9RQV+9AQ
         MJCdhYfqwXsAKd7uIZ8kbuHcVHuRxgnNOEiTgkJO9SYRhMP6l2wbUTej7p5ThZMRrTGj
         laRWQDEREK8sJFnqFPHcgZPH1eD27bnD17vDEaaKfrC3X21/8HeBJBTh1qmeu+pmsF6C
         olsAFPTJKLenQhQ6ldaes+2WW/QzgmtmBvGgCaH/NN6gYIxo8614OB0sbRvPp2ZX7Wuk
         Zn+A==
X-Forwarded-Encrypted: i=1; AJvYcCVvI75QaIS+2qaJfY00pEIB4UC6/0nThEGrzJM8u7tkXP3LfgZxziPTKd00dDv+AKwXp3upiTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygx3uuff70tMRDKwKLyRS7GGlkPhqqLJcywDMkgLif8OqL/onk
	a1jP70Sm/6ymp8Xtn+4Cf8o7iRfENQnAoxRCaH8ziXhD97GdRUMsuoLYuCYKKdzt/WpyTYnevQk
	9EkBBukuVfl2bzgsMjAemqZprSFpoBj8=
X-Gm-Gg: ASbGncs5caO7Yh58huIeEzwv/I69fRYFFLddyjqPG/31yidXYh5UjVRoZKquU7BZWZv
	KUYhqu8LRgX+SXgqT8t1E3kaxL4M6T8fM1vRekDpf31v5QNHL3qEzBHrmP+qGdMNxoDfvqWiRA1
	rNiFYSr6uwx0vvFqlQVChstTK8eKRmArX10FOy5Kf5Kj+bZULerxOWxKCCs8OcToLOZVifwPO/I
	LQXTitj7rNsZTJrMZH/FCu3sLHonT7Ku/xjMIXDhgh1lSK5crKuGgoqmdfuZcZE92utftdU7uXp
	3NIHTQWIQ0e1bkRJyg==
X-Google-Smtp-Source: AGHT+IH25QaUjzLpQ0O3CRwITusfe6pCAMVCPN6AMnU+eDbCy0CGb6riE7azc0Q1GIAoescCF4JMVu/lrJ4ie5xkUk4=
X-Received: by 2002:adf:9d83:0:b0:42b:3083:55a2 with SMTP id
 ffacd0b85a97d-42b308356e2mr6235388f8f.63.1762828878146; Mon, 10 Nov 2025
 18:41:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104104913.689439-1-dongml2@chinatelecom.cn>
 <13884259.uLZWGnKmhe@7950hx> <CAADnVQKQ2Pqhb9wNjRuEP5AoGc6-MfLhQLD++gQPf3VB_rV+fQ@mail.gmail.com>
 <5025905.GXAFRqVoOG@7950hx>
In-Reply-To: <5025905.GXAFRqVoOG@7950hx>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Nov 2025 18:41:07 -0800
X-Gm-Features: AWmQ_blf7ZxJz9aQNYoTKPbgJ8K03XqCzzaO2O8UCyW_1T8GZg-hL2D_ArTOHB4
Message-ID: <CAADnVQKxV7cvwvCMD29sqs8yt0-xQ2XVb-e6bxkTFZ2EzS4DMw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf,x86: do RSB balance for trampoline
To: Menglong Dong <menglong.dong@linux.dev>
Cc: sjenning@redhat.com, Peter Zijlstra <peterz@infradead.org>, 
	Menglong Dong <menglong8.dong@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, jiang.biao@linux.dev, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 5:28=E2=80=AFPM Menglong Dong <menglong.dong@linux.=
dev> wrote:
>
>
> Some kind. According to my testing, the performance of bpf
> trampoline is much better than ftrace trampoline, so if we
> can implement it with bpf trampoline, the performance can be
> improved. Of course, the bpf trampoline need to offer a API
> to the livepatch for this propose.

Sure, then improve ftrace trampoline by doing the same tricks
as bpf trampoline.

> Any way, let me finish the work in this patch first. After that,
> I can send a RFC of the proposal.

Don't. livepathcing is not a job of bpf trampoline.
Song recently fixed interaction between livepatch and
fexit. We will not be adding another dimension
of complexity here where bpf trampoline is used for
livepatching and for bpf progs.

