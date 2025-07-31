Return-Path: <netdev+bounces-211254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B796B17615
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 20:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3CEC18C64FD
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 18:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE2C2C3245;
	Thu, 31 Jul 2025 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="mL53blYd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489FB285C9C
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753986422; cv=none; b=QdSiGI2EnfIpdg8NcOzYsOVZpGSco/GAjBdC01s3nj5GHVYdCBsID/09MEk7I6y+0wDY5m5Fz8qoI/q6LSVcGl4zSUCimCuAhWaLU9SiaRZc/IITGE1U/xNP6+W/QAIZaWULmvLnw9piyZ9nJX07z/MwCigcyhhCLtgOSFe8gXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753986422; c=relaxed/simple;
	bh=GtQWjKEQkJYyltX8RlHLbxytlYr9I4EyRg78uDyghu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bnr1b7b4LQqqXtCRjKC4fLZFSRPlhQvGKdU8F+piLpxHlyoU8FHdSmsCu6v4c0Py8l/yNcINfn3F2XWCHBGpANmh3dQHZXXJE96R40Srlkg2Snetzfddcva5sRzia2tibS6eKrBdbi9uSOgJt9GJCjF/7n6G/D4ndXljZpjLx/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=mL53blYd; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e8bbb605530so2066536276.0
        for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 11:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1753986419; x=1754591219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rctzM9XOdIgWPvckF/hUJbH10KJkz+9ckzak4WdBlMM=;
        b=mL53blYd8RLZXGYKMYfa3zf2xWFllIcpCMt9gWnfumv6WJLGLXZxJqnsKIs0t19Dw2
         GwUr4eoY6eNHActDSyBnlgHNImBaXS9YPntdUjIcOs6sTL4/QY+f9qKynjjD8nq+6auG
         u3vIH6aN6mOYkKqDk9A72YGvZX366W8xMaHFM62M0ttIbPEXpOYprvmeOZixJ7bNzd2u
         6jLhEzIlfRmjOEUspM/rIC3uye5FL8lCOHFW8HPgyE9PQyu5ggy3/zu0PxhCgcZtMLIx
         /bmhdltoAk1AwIzQz2/y8UdSikK0T3aovF8vMVIPicSLh39CtHGzPZYDOjqxo0StKu5t
         e1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753986419; x=1754591219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rctzM9XOdIgWPvckF/hUJbH10KJkz+9ckzak4WdBlMM=;
        b=Zzo1UJPSPVEvRyVzuW3H0INVX0YV1a8adl4PJsp0tu+JNMlH0Q/XvPitDcbNEpgohk
         K0tG7ICzT0M4mlMVvPteT4Ft3lo91oczycJguPlZUzeU9pGjVCmy+fsD46TtQgi5R796
         GZAaoqthgAxwA/dg2qladgaC7JwnvBCJts50w6r6qcckTqGxvHC4UQVpRvpKu3x9xwLq
         dagHMuDiIuivNaarmU+ocrYKLW9/zPH535srAIKhQDvQZ5VmpzJuKfflhSaYohKin5A0
         MgjfAXanNvv8C7pFz23v3o7/dxUguqsJh5cFv5aDdn9L2ofzzo+nBwhnN7aezb3YpmFU
         +bDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXNTerxuFiorCZsoQsNM+5ijzf0dpSMJAoa5TRYXO7+kpLhVrYUB9pcz1V0asFLVVUP2rMzSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYWLAOEy7OOGGDLM/11TWyJDAGDZEb0JeMKjqncHiTS5vEL2ef
	9Facb5EMlR8oxLEWCLGnNTtyV0NStOy6pUgn59xGdfEG1UvgUsmYpXsiqevfKeEOkQtCnzPFSke
	V6wHRXobG31QfkdTowxLjK32Bbny/DrrdQxXiTsL8vU4HkcFcudBiz6s=
X-Gm-Gg: ASbGnctv2UJWWmgu8kxEeUpPGh2PKzDLpwaAEeFXoGjqTZEBH+KxEQU5Mg1kV+L3GcG
	Av8gKiPF8wgIdTxUAFZ+jT15KZuHBxUMYlJhM75BeJUsXUoKYz/nfnAMGGZOlDMJbZy3CLfk6Nc
	ZjKc7x+UFjJ0wTT5w+UhcLf58vS9TSAIvKa99jydwiF1+CntTb2c+29dIROtsL+0PfEOUXTrBzX
	3xIpqCuEC9L+QobHIk=
X-Google-Smtp-Source: AGHT+IFG6fDK9T6W8TpYKJCImcVlplfmZYZw/KMAbds0PdGq99TTcgxL3cQbYZfufBSMxlbkOTaWT04+xyaAhyuyrmY=
X-Received: by 2002:a05:690c:338d:b0:71a:1c70:c221 with SMTP id
 00721157ae682-71b5a823421mr35905197b3.15.1753986419093; Thu, 31 Jul 2025
 11:26:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730185903.3574598-1-ameryhung@gmail.com> <20250730185903.3574598-2-ameryhung@gmail.com>
In-Reply-To: <20250730185903.3574598-2-ameryhung@gmail.com>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Thu, 31 Jul 2025 14:26:47 -0400
X-Gm-Features: Ac12FXzEUt5j5FHYWw2iZkDfKdpLCJ23nZOiCCRLp6iQ9aXG30xgzvXB8Qi95KM
Message-ID: <CABFh=a7FGM--6M+TKZbx17MydEW5zTksrdfwWQ9dTHnrG=C3zQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 1/4] bpf: Allow syscall bpf programs to call
 non-recur helpers
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 2:59=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> Allow syscall programs to call non-recur helpers too since syscall bpf
> programs runs in process context through bpf syscall, BPF_PROG_TEST_RUN,
> and cannot run recursively.
>
> bpf_task_storage_{get,set} have "_recur" versions that call trylock
> instead of taking the lock directly to avoid deadlock when called by
> bpf programs that run recursively. Currently, only bpf_lsm, bpf_iter,
> struct_ops without private stack are allow to call the non-recur helpers
> since they cannot be recursively called in another bpf program.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

Re-adding the tags in the case this is the final version, as we
discussed off-list.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  include/linux/bpf_verifier.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 94defa405c85..c823f8efe3ed 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -962,6 +962,7 @@ static inline bool bpf_prog_check_recur(const struct =
bpf_prog *prog)
>         case BPF_PROG_TYPE_STRUCT_OPS:
>                 return prog->aux->jits_use_priv_stack;
>         case BPF_PROG_TYPE_LSM:
> +       case BPF_PROG_TYPE_SYSCALL:
>                 return false;
>         default:
>                 return true;
> --
> 2.47.3
>

