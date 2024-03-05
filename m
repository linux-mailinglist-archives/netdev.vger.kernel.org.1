Return-Path: <netdev+bounces-77447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BADBA871CE5
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 12:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 674A7B26C67
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 11:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84C0548E2;
	Tue,  5 Mar 2024 11:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxyVJp1h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCE3566D
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 11:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636772; cv=none; b=gh5dqzHDD9wEyc0O8TKY4s/rRNevLgz4iQ7yTjUIBqSlG/hwdm8PSPbXO41amTV7jBTbsyhaTrApWTzdeTNteIT/nB4onUi/FtKqet1rM4p4xofK38+VlDsHLS2+EswsGVXtKlsp8m/KgxzRUqRZMf2Wi8YrUK4ZLtAaTJuekhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636772; c=relaxed/simple;
	bh=xjtOpQLgaU6smOoVOUkI+Z9W+wD0UaifL0++UandV/Y=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=PRIoyuBzaLTupELM0REd7CjjFOlWCjTm5CVVGRUF4YnXPQAjEOyMWdle/ciuoTPXhVxr9aNsZIa2GFIf16wTCnz4Tvl8G1jqP5BJ3Z9gAF0MOP/21ZtFk6bvS7Le+FW7dFKXpmmuaRebpDz+0v0jsYdvPkGLMK2CGtbaC+8CSwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxyVJp1h; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33d9c3f36c2so316104f8f.2
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 03:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709636769; x=1710241569; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xjtOpQLgaU6smOoVOUkI+Z9W+wD0UaifL0++UandV/Y=;
        b=kxyVJp1h5cLmDjDuoZpoQ7JKbiDPxONK+B5cz38emF7Zhq+Shg/YdUtAldKfHDjfvr
         zSwD2KPexZnjFa8CsYEloTOmhPc7uXjb9D2TguD/ayJUpGXnXHX8uJ/GV+Up8CUmapat
         ouF1WLjONjGSNkbXa7ZU2PKY99gntH35gUM+vNuuvTDpQCeKx0d0ysS8hJpfDlhZ/W2M
         BAisOa9MpQzfVO1J+uVc5EGEV+xNo/rm1wvavy6+mpiEqE0+5BMulQliK17NXrqORLIU
         XauRNfLI7BzxLyqUzelNIcfSCLptusP5sOsekJdg+obg36zHz5jKDvyzntCGpRXVc+0h
         mf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709636769; x=1710241569;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjtOpQLgaU6smOoVOUkI+Z9W+wD0UaifL0++UandV/Y=;
        b=o9FPm/bpUsUlw8ds5imZaX6DwQBOv3KHK6BNOTfdINdJOhl9ZVPRHTnEaUs5ntkYMk
         rHPwDVwuZG9UUrbA4doLLSt47SFjlWTFYKQNzWJURbrCgY9OMjrS1vpmfPpK4nNGN3+s
         WIHgi6BqR/0XVDg5qQHR3V0TnG7kmBaT5bPNDria36doc7g1+PM9r3e+6aT9eqeVS7D1
         aOB1iWrYdpQ1+eoNoUBtquluiAGiSlRwpHx33VYTPzHp7IU5z2R3nhvsr6n71C6mdl0u
         aHIpSTXuCKw9x2/deUhwXG7lSnHnqGuivkDNt4zjGAdVYl4RxkqE5QAxX3361nY70eGB
         negg==
X-Forwarded-Encrypted: i=1; AJvYcCXwckip3Hjxh0OclFVQhi9A7xhPAK6RuXSYhsxLwF9GgovTh7YzD28LF1mJgsJ0LjQF60wlPG42bkcjUlkQGuUsPUpVueeY
X-Gm-Message-State: AOJu0YytuIC6OpptGncm/bbFy6+ZD63Mt0Fp/7hZTd17Vj5aOjqbrNey
	2O49cchN2zaQNWjhGV/af2Ol37dIjz3uXznJjDHDKicaKR4ao7DO
X-Google-Smtp-Source: AGHT+IE/II7xKXcnj6TRdYx+lF0Z46LkVxFJSXswuNIOvNoHNd6mGn8BtyK8gEWlCK+00RjOhHgj/Q==
X-Received: by 2002:a5d:5749:0:b0:33d:82b6:871b with SMTP id q9-20020a5d5749000000b0033d82b6871bmr8806265wrw.56.1709636769200;
        Tue, 05 Mar 2024 03:06:09 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:554f:5337:ffae:a8cb])
        by smtp.gmail.com with ESMTPSA id l9-20020a056000022900b0033cf2063052sm14599349wrz.111.2024.03.05.03.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 03:06:08 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com
Subject: Re: [PATCH net-next v2 1/3] tools: ynl: rename make hardclean ->
 distclean
In-Reply-To: <20240305051328.806892-2-kuba@kernel.org> (Jakub Kicinski's
	message of "Mon, 4 Mar 2024 21:13:26 -0800")
Date: Tue, 05 Mar 2024 10:56:02 +0000
Message-ID: <m2r0gphrr1.fsf@gmail.com>
References: <20240305051328.806892-1-kuba@kernel.org>
	<20240305051328.806892-2-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> The make target to remove all generated files used to be called
> "hardclean" because it deleted files which were tracked by git.
> We no longer track generated user space files, so use the more
> common "distclean" name.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

