Return-Path: <netdev+bounces-237993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 401F4C5288B
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 14:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A4842284B
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 13:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE073385A3;
	Wed, 12 Nov 2025 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHQrqU+G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C56337B9D
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762954551; cv=none; b=jChKYRPLqg8aN7dMOkdarGDZOEZ2iMIcuK9rdInVPpS+ROr71I3SyX0JYSFBgdaubT4haF9jbDquKjpm5F65cxrTZMGdy+aJnyZBq2yUKPNrZuTgudWShWbNN7eLakREXTW31fhoN2BRNFe9vDPTKbhgZjU5NydtHoRdcW3kLhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762954551; c=relaxed/simple;
	bh=/Brd79tWNwS4wv+IDvBNr6c5hIBAjx2K749TKeHBGs0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YLfHvwM+uLXE/XKsPbQKDXR3XsCmPGz1Klp05ND4JY+cFEiUZZsgBC0lJxrr2YtBHBzCiWnD3TrEGQtMR4URViBROWtX4UrxZ2OIl4yA6mpg9uT3rYaM5F2t3PQ5pxuaDZvI87xCzQhFqFoT1u8QIp3q/BG2w96i+2nrPv58NUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHQrqU+G; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b312a086eso617133f8f.2
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 05:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762954548; x=1763559348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7H7Z174BA0f5baKU5PBBRs+kyychkUp/6tsJBIR6AU=;
        b=gHQrqU+GB+1WCPxfWAjOWxTmc/xGbZsb7W1E19zX8/vKqE3F4lXR0/imNKquQ7ZJdu
         cqbSTYkwPy9X21CVf6aPsNiD+ljLWidKxbOoApxEjgp94H1ZKHNZUwItBJ5qDX6X+X+7
         j8ONQhvF/ctX1lTg28jDlmWiGRk2CwrEohztVHV9s0yDAayNbpXZW3k+IsuegCtK67KR
         SnQjPSufrXoadKYpmxtHp3lGnQdfYCWsrwQaDKj8YDTy+VRpiXC3HS/JVHq2H9tf/bOR
         lrOr8shVHLiz9AhmMOtmt9VG7q30eTM9p4+LmeyS9ZviyZm0P6QAHHHplrIOaYN4Kn9Q
         YujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762954548; x=1763559348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y7H7Z174BA0f5baKU5PBBRs+kyychkUp/6tsJBIR6AU=;
        b=dTk53hdFmUXxAyqrSvYyaLuqwfTWPdvNsrKN2AuUVkKUzSrdMNGXu/vKhi/ytpJCOp
         PeZXHE5qc8FrmEh9oM5cmcfZPNDx6gZUboaTr8Nn5tyRTxkfA7uG+Bovu/coFt0oRkNN
         IGsYgRGmeFBTcJux8wyijYeupybn/w0vE1ngiZbWwa1pmMfPOzqnEoeTyr0tvvzklRpH
         m1syHfskvjn4uKGKW6JfNpWlkZn68F+qVnP1TAgDXV81gBe3mMiF4XUhaLWOD9Fi+OGE
         M6xpmgrzz3vZgVx6yf2ncJ+pHjkCSYM8WD+e7qTPhkEfn/zl0D5DKwM8Cx5+muSek6n4
         p5dg==
X-Forwarded-Encrypted: i=1; AJvYcCWDW/VYKSS9rUJWRtJ7S6u3MOsT4JMCM4/ps1oFpxkKwtmXkjDpaNk6ZsPxMSBMmXD5t3xAqh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz59PLOyDDp5en9cCn/ggwvIvi483xQyrzHIG6hQ97LwSCCPrxJ
	5gyGp57q5Y/GsOadoA2BHYOpdEFJ/kWAV70L9zr3hwtzRrlkVQIPVKNU
X-Gm-Gg: ASbGncvo0HfEqm7LU+QTWL0+LgXnDswwtHJhL6H6YnF90dPT1aBSBuXZciO+3LwytJv
	bB2ejPGBtCdyZQ918ZxFsgm7BrBNn2MJaBE9Va+kXyOFbfPkQthriK0TW4rz0xUcwh/Ux4/OxbJ
	NocFDLKCRUglnd3iD5jnmk7ZgaPswYQhlw2zhohGqtgDOK7DI7T9poZZuJ7aUZxCvZdyI68k/dr
	oeLg1V+xPthIn/YgPsdnpUf4bX9RKCY1eKo1flVX23A/KdvbAlnvJf0UBp3HW9izrVMm/wcYsX1
	QQs11U26DKK6t4lXY/fQAgXt/5ugskYpO1/sCAH1Kt0brCOB5lEC0Ph9vK8xfCaKqnMFQ/sxmik
	2+kyoetEM8QI/uKUrGXSbTetEx74Fb17CTjtM1N9ERJaMpAObeyzawlRPkyRigeNBZNV5OZVt+T
	kx9O/AWGY1yTRmcsKxs6zblm68jU7vyknctcekAhXwyQ==
X-Google-Smtp-Source: AGHT+IFsPr91yEVktw+9zOEmqEeRPgSJYJvxvCq62TCHBnCk09rlnxT7KPaqnY3oHV1wY+8b0MIIfA==
X-Received: by 2002:a05:6000:1a8d:b0:42b:3592:1b92 with SMTP id ffacd0b85a97d-42b4bdb8eefmr2538034f8f.47.1762954548135;
        Wed, 12 Nov 2025 05:35:48 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b30dd4d86sm25445445f8f.26.2025.11.12.05.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 05:35:47 -0800 (PST)
Date: Wed, 12 Nov 2025 13:35:46 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Brahmajit Das <listout@listout.xyz>
Cc: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 contact@arnaud-lcm.com, daniel@iogearbox.net, eddyz87@gmail.com,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v3] bpf: Clamp trace length in __bpf_get_stack
 to fix OOB write
Message-ID: <20251112133546.4246533f@pumpkin>
In-Reply-To: <20251111081254.25532-1-listout@listout.xyz>
References: <691231dc.a70a0220.22f260.0101.GAE@google.com>
	<20251111081254.25532-1-listout@listout.xyz>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Nov 2025 13:42:54 +0530
Brahmajit Das <listout@listout.xyz> wrote:

> syzbot reported a stack-out-of-bounds write in __bpf_get_stack()
> triggered via bpf_get_stack() when capturing a kernel stack trace.
> 
> After the recent refactor that introduced stack_map_calculate_max_depth(),
> the code in stack_map_get_build_id_offset() (and related helpers) stopped
> clamping the number of trace entries (`trace_nr`) to the number of elements
> that fit into the stack map value (`num_elem`).
> 
> As a result, if the captured stack contained more frames than the map value
> can hold, the subsequent memcpy() would write past the end of the buffer,
> triggering a KASAN report like:
> 
>     BUG: KASAN: stack-out-of-bounds in __bpf_get_stack+0x...
>     Write of size N at addr ... by task syz-executor...
> 
> Restore the missing clamp by limiting `trace_nr` to `num_elem` before
> computing the copy length. This mirrors the pre-refactor logic and ensures
> we never copy more bytes than the destination buffer can hold.
> 
> No functional change intended beyond reintroducing the missing bound check.
> 
> Reported-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
> Fixes: e17d62fedd10 ("bpf: Refactor stack map trace depth calculation into helper function")
> Signed-off-by: Brahmajit Das <listout@listout.xyz>
> ---
> Changes in v3:
> Revert back to num_elem based logic for setting trace_nr. This was
> suggested by bpf-ci bot, mainly pointing out the chances of underflow
> when  max_depth < skip.
> 
> Quoting the bot's reply:
> The stack_map_calculate_max_depth() function can return a value less than
> skip when sysctl_perf_event_max_stack is lowered below the skip value:
> 
>     max_depth = size / elem_size;
>     max_depth += skip;
>     if (max_depth > curr_sysctl_max_stack)
>         return curr_sysctl_max_stack;
> 
> If sysctl_perf_event_max_stack = 10 and skip = 20, this returns 10.
> 
> Then max_depth - skip = 10 - 20 underflows to 4294967286 (u32 wraps),
> causing min_t() to not limit trace_nr at all. This means the original OOB
> write is not fixed in cases where skip > max_depth.
> 
> With the default sysctl_perf_event_max_stack = 127 and skip up to 255, this
> scenario is reachable even without admin changing sysctls.
> 
> Changes in v2:
> - Use max_depth instead of num_elem logic, this logic is similar to what
> we are already using __bpf_get_stackid
> Link: https://lore.kernel.org/all/20251111003721.7629-1-listout@listout.xyz/
> 
> Changes in v1:
> - RFC patch that restores the number of trace entries by setting
> trace_nr to trace_nr or num_elem based on whichever is the smallest.
> Link: https://lore.kernel.org/all/20251110211640.963-1-listout@listout.xyz/
> ---
>  kernel/bpf/stackmap.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 2365541c81dd..cef79d9517ab 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -426,7 +426,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>  			    struct perf_callchain_entry *trace_in,
>  			    void *buf, u32 size, u64 flags, bool may_fault)
>  {
> -	u32 trace_nr, copy_len, elem_size, max_depth;
> +	u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
>  	bool user_build_id = flags & BPF_F_USER_BUILD_ID;
>  	bool crosstask = task && task != current;
>  	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
> @@ -480,6 +480,8 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>  	}
>  
>  	trace_nr = trace->nr - skip;
> +	num_elem = size / elem_size;
> +	trace_nr = min_t(u32, trace_nr, num_elem);

Please can we have no unnecessary min_t().
You wouldn't write:
	x = (u32)a < (u32)b ? (u32)a : (u32)b;

    David
 
>  	copy_len = trace_nr * elem_size;
>  
>  	ips = trace->ip + skip;


