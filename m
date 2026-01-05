Return-Path: <netdev+bounces-247167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3E3CF5262
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 19:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5B03300A3E8
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 18:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C7D32548A;
	Mon,  5 Jan 2026 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPJRUbmL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160223242A4
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 18:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767636271; cv=none; b=WaLhyqZvoJZTGQpsDKBIfcQXYWbXH+vhayIKWerFUi53gvhE+Bv1m2kEXJd8QLOrhcdHACZHxRE+KKqwJVBOTcFqU/suF/v8Un0n3wClSW2OOhrDR99eVk+HhnvT1W0MQ7v0AR3ugRhpCFD56da+RFxMPum7rZm1KXk4qSGQAvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767636271; c=relaxed/simple;
	bh=AhaYTyxOuYDk5hXdYvveTxiwI216+Eiw+AvkEGOQl30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dB+1/Y+lOaxn75cVuCOPqrWVMQIiWCsTHjVTln6KX8ekkEfhYE/lLK9+3bQ8wpqR3/b3NqZI0r/JZRMoIH1/oJD8DEF+Lm894wOEbvomLsb3Aj39kuSFG55/92vqy24lWaR/cU9/K421r8HucsPmZaCaBjZGvmtvCLQoL8k2kqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPJRUbmL; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42e2e77f519so74325f8f.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 10:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767636268; x=1768241068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gI8RtePXfwzwS7mkc1eRnRQkzUnZ4Oh1bnvBATGXTE4=;
        b=lPJRUbmLcSzgP28JjlflghLIYMpOAI7wNKvEOcoR1Jov93QuUQclnqA6Zw9iUQ/RjJ
         SUG6Doh9VFRyXpXv7lwfvk1S3ttZmtIQyhRMfLwknEJcUyKKo3ri8YRAFUuPBHdn/oW6
         Xcfq81WLzeYZ6RDKwTIZtJW8uuGWMaksunQS7/+Sx+FfnaGN9z4L3+nUDlMBJ+aNdjVG
         Tyf7IgJFkrmIVq9Lb8u1zleEeiPDLvCWyRWeonpLD4VGT+u4WiOteqhOxdxLqW6ppF76
         SoEUBjdfqXrKlMZ+H8pmxZk20OeQ2wALKhE78dquhusPqs03YSpccSpmMTtRnxrguwdl
         /R7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767636268; x=1768241068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gI8RtePXfwzwS7mkc1eRnRQkzUnZ4Oh1bnvBATGXTE4=;
        b=F0yOmb07NPYfDXtjrGvKYp7tQ3A0Gw8ElFYS37E8q0G1WRNoomb8y5Fp9+9Tv+qv3Z
         ont6KX6aSH8UUokGk3CKoEqJk7EqzDR0urI5BVlpXda9PFblAOOyqHOPDbQzAorb4u4n
         3/6zIKbHzhWSvtofMTBAQgmTQATVndZw4AdgDMCILCnHq3cFGuN9svlW4H29ky6TUKk9
         dvVBCzt9VQ6Y4VSN0ParaLV8hTST1nfTv6efc6cLDPjM5SKsQr6F4gTcmKzsDObx5YxX
         5kQN/kQGxxVaKbPHAyC/Q7M4PMv+h5ZLYxORaBmcKgIbNgnoob7h+u/LE3RoS9OkwUv5
         V9aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvs8wAYlKTRy4RMs8NQzEbjXDxlACGk9osLBh8//4vaVIfe1J6nJKCO2686qFiT1VjfyJgKXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJAtfGs1iye7RGemINDONaGo/786zW9ehe0QVHPVaOFCisJd/5
	G44oYigxpJBHulroJUkrNiOkZWl7Bzr8bhLm6GsqOY8GfdJUKz95ptzejXWUqixAjU588VxHYXa
	Nzv5RkQzQ2KkDgXu3asMMT0qep6xjefY=
X-Gm-Gg: AY/fxX6uOClkvOo8JHCkbsp1x5VrWag3uYJseCrM7IcmHHwiVPjihj+LzXOUjmTGnsB
	vVFbTbEZ1kCFcLQou0jkzdvrKdh2iOweZv7wgWk//DibSTG/6yl0FYMD3xK8vKon0SnO8u0z97t
	Sx7kRvhz8rXTKky/GWsZ0heziV0/VZaT80maGSkviI+08g50VcbWRjPJNTrSQIm86z7HWRSuseV
	pGLn6o5gozCiqOwSEf8EJI1m5Ra0NH1fibpEKNjO07FqIe8AhG/sUKYGprSRUIe6/PtHu19TDPa
	M1/Pi+GsAAjT3hsdBzSxnADWti8S5qrExMcDufc=
X-Google-Smtp-Source: AGHT+IHrsQw1QKbYe8LdWMiqz+dVSN/+stHeZIas7daFWJK2uatS06DRNRaNhywafyS372Az0OhKFHrHUW7o3CaRCaI=
X-Received: by 2002:a05:6000:1ace:b0:42b:3ad7:fdd3 with SMTP id
 ffacd0b85a97d-432bc9d0eeamr873537f8f.18.1767636268130; Mon, 05 Jan 2026
 10:04:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104131635.27621-1-dongml2@chinatelecom.cn> <20260104131635.27621-2-dongml2@chinatelecom.cn>
In-Reply-To: <20260104131635.27621-2-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 5 Jan 2026 10:04:16 -0800
X-Gm-Features: AQt7F2pauKhkLdGPfB35b4jRX1IBNZgd2lxSAmUpRQteTUoNsbefnAXbM8EY6BY
Message-ID: <CAADnVQLrV+0RB8REtcN9x+ub_S-DCrRqTj4s+QtX_ROrA=OwBw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf, x86: inline bpf_get_current_task()
 for x86_64
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Eduard <eddyz87@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 4, 2026 at 5:17=E2=80=AFAM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
> to obtain better performance. The instruction we use here is:
>
>   65 48 8B 04 25 [offset] // mov rax, gs:[offset]
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v2:
> - check the variable type in emit_ldx_percpu_r0 with __verify_pcpu_ptr
> - remove the usage of const_current_task
> ---
>  arch/x86/net/bpf_jit_comp.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index e3b1c4b1d550..f5ff7c77aad7 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1300,6 +1300,25 @@ static void emit_st_r12(u8 **pprog, u32 size, u32 =
dst_reg, int off, int imm)
>         emit_st_index(pprog, size, dst_reg, X86_REG_R12, off, imm);
>  }
>
> +static void __emit_ldx_percpu_r0(u8 **pprog, __force unsigned long ptr)
> +{
> +       u8 *prog =3D *pprog;
> +
> +       /* mov rax, gs:[ptr] */
> +       EMIT2(0x65, 0x48);
> +       EMIT2(0x8B, 0x04);
> +       EMIT1(0x25);
> +       EMIT((u32)ptr, 4);
> +
> +       *pprog =3D prog;
> +}

Why asm?
Let's use BPF_MOV64_PERCPU_REG() similar to the way
BPF_FUNC_get_smp_processor_id inlining is handled.

pw-bot: cr

