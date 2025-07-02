Return-Path: <netdev+bounces-203313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E36AF146A
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2AF71C284FE
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 11:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F252676E6;
	Wed,  2 Jul 2025 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SyqiSTPh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAC5125B9
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751456814; cv=none; b=O5lv9c0AGgQ1FFyrFJ3fK8IYK1qAj1C14DILkOdK7XnmK/YqYz9sHOnGt97+ORq3w8bjviniJPVqpYB/VoZ8pnfOzGFzkpzZ2kaJMdcVtGErwatmXb8PKTj5BRmDd/fqWG8xswT+vU2Nbxu8Dwtxira5B7FEl0M5Hn2zeyacNRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751456814; c=relaxed/simple;
	bh=B+ckTwhERKNBb1gQw1U8u0g+Bc8f/814LWyhbI7jr8Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OraYcG0qJMX01c81hVtaXyzwLi2CdJdDKTzoX+RXuIPrC4vls0Mpqo5fMETll85M5PQewBCyN6x+I70yg/vWA4IFdP8tFDVpXvoOuCTKRbo+To+ayYeL3zeYlKuCTzx9V/l6BGkWqVtSCR8amGlgwsU7IZnwLNJyMaQ6Jv3ukyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SyqiSTPh; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae3be3eabd8so199888866b.1
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 04:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751456810; x=1752061610; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=B+ckTwhERKNBb1gQw1U8u0g+Bc8f/814LWyhbI7jr8Y=;
        b=SyqiSTPhhIys5zaHLq6k61MH5pjvQFvzQwjMnE6mm2ds65agR+c6FkHWDCYk7JH3aC
         MYh4wzsRIRShF3PVpdNYuSITR3R40cW5u9D1YDtQ7fIvmQREHbqrS1whhKij2DQYNK50
         gD1lFUVz51D5Gk+mCT9GvUuExmDlO9A+9AflC6PS9VNmj13VYxzi5gcDhXZJ6Sb4n2gD
         8pjzhIvSMpvLUQDd2C8rpZTLmmNIWFf7khQgpTqpd0dewsqvPn/lwl9Pk8AatBGJU9k8
         6tmCDhNBv/GojB7ojr7f7b+3D0N4S7Y3ISPIeFxNZhxlF5u4oEmrJPLGJGAlaMo7hvYF
         0NXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751456810; x=1752061610;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B+ckTwhERKNBb1gQw1U8u0g+Bc8f/814LWyhbI7jr8Y=;
        b=H5IQWnr3FzY39V/jHtb0MYPTE6/kZPlZV6w+9wuAka4WwePURC/3RO5y/dHWsMXpjH
         SSCvItmD/iWtNUkbclXvD4P3NcONqUlxFnBAGctn+c734ZVnUUN+b07ivh78q6J/4ZnS
         Pzn0AhDElnOJxRc+Fdq3TTj/zDy6qjGbc2vDwAkCDMk/WQGrA3NKq5JcdGH3QBsZiGHx
         A1T4ukFNrCLthjHeBMY3HS4nA3/3frkSg7JWT1DmPSfhmTkPyJBRalO2BwQYLyDMZ1PP
         U3LOM/edTt0kzUsabSNUZhp2HuoNz8OXYKdnkpNm1mIpG6CwGxNswgGRISnSzokJatM1
         gQdQ==
X-Gm-Message-State: AOJu0YxtEQlxFpHU2h4E47HhjfTH+5UXnvjdO+fYIGx35eEktGxYjcGU
	/YN2Ua+npVANmMIWeP3EyQCxaYMc0/q5wg3fbKLJY+jxPvntWP9KZPMHjprMvMq+SMw=
X-Gm-Gg: ASbGncswMlo3O+joh/xWwyyKuuvMdUB6wwRb17Q7zVehBz7I5r9RwpsavW/U9IJxPBD
	ssPfJftOfHkv1ep1rYKNJpNcU48kre0A1o4cCDMjWJngtqNevPWDdPkOTCG4S5SErqMnJW6D/wE
	kzBrwNCYNyLpjEm0sjrNz+rXx9VFNWPXYid7io+zqOCYgxAlY3ZbqB7mkhjs9Gbq0BW9gsYwlaX
	AzJ9OGac4odigiwXkv/bbNcpbnq/keZ9yFTdCh2xRCDNRPXg/TOI1HKKGsalwEPRP23WDvk7PI0
	34maApmYsTclUV15d4q80jyF+mOWdEUEJX/v3bSQjsHCfSOnRhqiWbs=
X-Google-Smtp-Source: AGHT+IHn9IHAQjBFlntquHq7U7auo8n8gfpvyxwY1QPzU89J2geG4r9cCc7SijhW0jMSezFMElSy9A==
X-Received: by 2002:a17:906:c14c:b0:ae0:7e95:fb with SMTP id a640c23a62f3a-ae3c3843a2fmr207138766b.5.1751456810074;
        Wed, 02 Jul 2025 04:46:50 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:e7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35365a02csm1061393766b.70.2025.07.02.04.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 04:46:49 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  john.fastabend@gmail.com,
  zijianzhang@bytedance.com,  zhoufeng.zf@bytedance.com,  Cong Wang
 <cong.wang@bytedance.com>
Subject: Re: [Patch bpf-next v4 3/4] skmsg: save some space in struct sk_psock
In-Reply-To: <20250701011201.235392-4-xiyou.wangcong@gmail.com> (Cong Wang's
	message of "Mon, 30 Jun 2025 18:12:00 -0700")
References: <20250701011201.235392-1-xiyou.wangcong@gmail.com>
	<20250701011201.235392-4-xiyou.wangcong@gmail.com>
Date: Wed, 02 Jul 2025 13:46:48 +0200
Message-ID: <87ikkan7br.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 30, 2025 at 06:12 PM -07, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
>
> This patch aims to save some space in struct sk_psock and prepares for
> the next patch which will add more fields.
>
> psock->eval can only have 4 possible values, make it 8-bit is
> sufficient.
>
> psock->redir_ingress is just a boolean, using 1 bit is enough.
>
> Reviewed-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---

We could probably tweak sk_psock_map_verd to map (SK_PASS, redir=true,
ingress=true) in to something like __SK_REDIR_INGRESS in the future, and
do away with psock->redir_ingress field completely.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

