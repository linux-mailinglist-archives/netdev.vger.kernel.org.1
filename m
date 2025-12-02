Return-Path: <netdev+bounces-243266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F9BC9C61C
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 18:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4E7C0344093
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 17:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4029B2C032C;
	Tue,  2 Dec 2025 17:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PB39evq4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E42D299931
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764696434; cv=none; b=a/NZ0+w8fO+3ochVca1rlMMue22g14+JdbafIxnL5yYQaCJQt/BFHTNIoNnx8juE/+8VXQzYK9H2DDCgb+71BsDqEMyWRtzaPaw5fxxgUconaXEpAVhBeVlcz+2u7VSUER+qZPmUCD8JSPBnlzqOsPomEoQ9yQo851ivVtvILHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764696434; c=relaxed/simple;
	bh=lbprACJXOsDs9quCd1cHPcC8LxjPjXJX4lofHSs/8P0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ix/POXquRXrPK++ufc4yC8frfs/VLy7cpfgBQ3fo7q16OMgF3HTh8xioIzpFl7ayGnJl9RC7GaNRJQCV4d4B2P0iAn5PU8KmbjUf6eMGJHFxs9kNuC1aIo19fDJijO32Rl/p0Q6koVqxOE0IcqumpOoUohzXxbngbsk0qQnaX1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PB39evq4; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4775ae77516so56167795e9.1
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 09:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764696431; x=1765301231; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L830+//zOm25WYXSXk+Iz08LvtsPyToF3gamuliHtQM=;
        b=PB39evq4Ke3G9HYkxIDdAnJ4yBL5c4FchOPRmH+TP6cZagRbMfpemiwiaq5Zttpaas
         4QErHrD8VeBo6opPKgW5k1fWPwGewanbSYIdk+WfPzjkpXxFamUrFF4sCA/bpSew9RSz
         4dHJN/J/lXC7hpGXw289dIl7/mfSqeD/ZzPCRCDi9QRQFfc+MKvEuCkPFfL/LrqR6zWv
         YJrnJGJZC1U4cQSutVB5S4FhCgbXtdKPWxfloR/pCDqVT/d5h5zAhJ2xSxXSpoiUXFhF
         E30597g70Gi4iVM+ASk0x3Fj8Knh/64nLqKmS5ng94YbixT6GpaAa4ut/lfcFqVtV03D
         ljcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764696431; x=1765301231;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L830+//zOm25WYXSXk+Iz08LvtsPyToF3gamuliHtQM=;
        b=PdZb4lIkDyQBMrdBfE5UHgTQfxqeeWiagGjWvTYkX8DOONfybNwk57Mkncb3biSFnK
         zUcioVjqO6R3XMLe0HegETgy1n60OrBSfeHBpZT10u7ZCotFM1lMopnZtJlQMSXhy2Eh
         0sgNpc8VFoS0C2SZYoc1R4gz7Y780GJ84/wyVwktG/URdW4XeqgiAq+kNAZf1A57sh5S
         eegKqtCPQUqfcgEVCfln0FfDoqmzBWn7tcgmltd3jR3RuZAo1huhscra2TpmstmhruEG
         cEYxlahjXTi2F20AGuIUeEdekUrt5FDsgxi7yJVUDgk/fjlSpCuKC4YDF0q2La6F0vQc
         R8oA==
X-Forwarded-Encrypted: i=1; AJvYcCWb1s7fXIJi8YLxl2Glqv98fYEXwUpVNbS+ObjcvyPvuUV8LKdc8rlrJ/3FmbyfbaQyXWaMAwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YySktskck393sclszBdC3bu7+PCYJFM31rcjoMenUChh7aY6O48
	MWUOsNw5iLpZNOOdEJ2AHHQVy6EQvQhlgRpL5Z7aXOJrFx1vVmsSiuNw8RWEAUzvlDJHXP8QTdb
	MxRpOaZ/ij39bhqxDRw3tu1wuwQNQTTw=
X-Gm-Gg: ASbGncuzoyS6FmI6wYCzX+pH8SQbVuszxTnLNQqHDYyUSmPXbTavH8V/cdFY3MEDRiE
	kTv6DysEYCaQKyfNJtxvduaXcHoRpEg3rCky4OGb70vU42Zs9daNN1HOqwPkgwFWkojruDamRmX
	oLki+slOB0XqKgmTOEi1rFckcxu6oSGBXt+laHc5s9MoSw5zhtQ8l08OYluVGV+sKh+SziJyqyF
	iSaMMS//TA21DmW2O/Mr2IOR2Mb/kc6ftWfoXB4UQ+KB9on49MgmnEGo7h967Hm0EKAA/8nIcfe
	+hwcDvs2DnWI8F8pgUrJ72o+WZtp
X-Google-Smtp-Source: AGHT+IGLJ+nbQjGFp53SgBuaj7GBJvlo5YLxoq4TlZ1krH5g2A3cvjCUKTQbkdSGyvDEqtgNp6MX3X0+AiCB9ZfW9eU=
X-Received: by 2002:a05:600c:4583:b0:471:14f5:126f with SMTP id
 5b1f17b1804b1-4792a4b0848mr3473515e9.33.1764696430746; Tue, 02 Dec 2025
 09:27:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202171615.1027536-1-ameryhung@gmail.com>
In-Reply-To: <20251202171615.1027536-1-ameryhung@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 2 Dec 2025 18:26:33 +0100
X-Gm-Features: AWmQ_bl2lk2cCWi9ldDTVZI-Wy6MPjSccB7QvC-nW1ieyYidfYW3YZiamy3Jsiw
Message-ID: <CAP01T75C+Zj12g08q3XE2X+TV8Qwx_dua=s489w71or2bu64gg@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Disallow tail call to programs that use
 cgroup storage
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	eddyz87@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Dec 2025 at 18:16, Amery Hung <ameryhung@gmail.com> wrote:
>
> Mitigate a possible NULL pointer dereference in bpf_get_local_storage()
> by disallowing tail call to programs that use cgroup storage. Cgroup
> storage is allocated lazily when attaching a cgroup bpf program. With
> tail call, it is possible for a callee BPF program to see a NULL
> storage pointer if the caller prorgam does not use cgroup storage.
>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
> Closes: https://lore.kernel.org/bpf/c9ac63d7-73be-49c5-a4ac-eb07f7521adb@hust.edu.cn/
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  kernel/bpf/arraymap.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 1eeb31c5b317..9c3f86ef9d16 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -884,8 +884,9 @@ int bpf_fd_array_map_update_elem(struct bpf_map *map, struct file *map_file,
>                                  void *key, void *value, u64 map_flags)
>  {
>         struct bpf_array *array = container_of(map, struct bpf_array, map);
> +       u32 i, index = *(u32 *)key, ufd;
>         void *new_ptr, *old_ptr;
> -       u32 index = *(u32 *)key, ufd;
> +       struct bpf_prog *prog;
>
>         if (map_flags != BPF_ANY)
>                 return -EINVAL;
> @@ -898,6 +899,14 @@ int bpf_fd_array_map_update_elem(struct bpf_map *map, struct file *map_file,
>         if (IS_ERR(new_ptr))
>                 return PTR_ERR(new_ptr);
>
> +       if (map->map_type == BPF_MAP_TYPE_PROG_ARRAY) {
> +               prog = (struct bpf_prog *)new_ptr;
> +
> +               for_each_cgroup_storage_type(i)
> +                       if (prog->aux->cgroup_storage[i])
> +                               return -EINVAL;
> +       }

Would a similar check be needed for extension programs (BPF_PROG_TYPE_EXT)?

> +
>         if (map->ops->map_poke_run) {
>                 mutex_lock(&array->aux->poke_mutex);
>                 old_ptr = xchg(array->ptrs + index, new_ptr);
> --
> 2.47.3
>
>

