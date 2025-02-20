Return-Path: <netdev+bounces-168220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EE3A3E28C
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C46623A1AB8
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 17:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623EA20F09D;
	Thu, 20 Feb 2025 17:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwzLx6IM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FE81E2848
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 17:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072447; cv=none; b=AtCxk2lom4sd3uN/1J1z5YNtShARQq+BXYDkS5e1zLd/mrFqcSTxmSgvoH3KfJU2dQhmGSyvEhQEg5CGSaA8knuXet+iLJo2EXnPiTIaGPfDbKZDPlzC7zuMgTZ+ps9kD0iiTp34ipRP6KaCx8TTFjxsUOjEj8H+i8oLNa3UdoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072447; c=relaxed/simple;
	bh=3nsRo0BPT7NRDmB6r0dLHAHdlqYFH1XGl7sBeEdZrZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4iSbFI7movrqbe/irdnQ9CUTM+pgfdticyokWDqHiGk9CV9HBfVHsXHS5VtRVpWdwpmGnmscsHXeK1dSi/XS5wXbuHTqaVhset4RS9SYKDL5+z5yZSeaaoG83P7Hxc4tKj+TN2tsGHAqmQsQ7G5bVQGYS6R8RVaZIJRiPZz6zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwzLx6IM; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fbf5c2f72dso2043427a91.1
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 09:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740072445; x=1740677245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Tec/OUNbFd626AV1pRHWpfP0ld0Z+MBngzr2ea5AHQ=;
        b=cwzLx6IMxlOuBo5pBuRm+0WnFlUmyyc4pslB8XWQbFV8qdtWg1+YqC+bYb/pbBCzCO
         CFA+YfPv29CZca5Vr0njXl5EOaVwC5Xfm6D6YnmHhJLsQQJ9r8l25+qQCwCeTm1xwry8
         OpTS6e/gplImdjSQ1rPyOlQPLb/3DlHbTeKuqsw8qkoVEkHr+7Ghq7mSpAgjDehps2qh
         01iK2p3jdxOlk7D0JxV2UejWkpDj9BSZjhmc5Et8g68iM4kQt7/fmmpiCo70lWfMCLvG
         XuZSfE+ofOdTop9hCMlszaNYH1azQqT/7IBrHvVCJYmSI9c90/eE/wmPxGQDn0C15rKG
         yUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740072445; x=1740677245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Tec/OUNbFd626AV1pRHWpfP0ld0Z+MBngzr2ea5AHQ=;
        b=fqD8hlMYhLSlR1U7+JR+KozPLPV3AiWLDrlN5hLguismSFHogis67NTp6Zvs3HTt+p
         OQjfq1eUzcnz2fvfdX4LVAJnAqxIt+bd+USy7c4szJz11JfEiubRnqEfXAh06/2a2FPw
         6abDTCjUhVrL5fvBLBfpYmk/bEEB00SC12i++R1TnobnA95liShav/I6iKOJx3tYLfmr
         HnZ60Tteau044xkQx/x750BRHDgGtXYSQfrvuSRtPVw6URKB+93NEfqSkMZBm+WBUWXA
         QVLkHw1K3Nq0T70qcHzLRczg/m8C8rZPAur137SZ5Xl6VY8KfN4X/gvCi6MeC5Wdmu1o
         dqFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9ZdbotoMckNq9ig08kpzRvIvCSjpzUJkq5soDRB5+FW/9jfEokIi1Nn1TMMjlfxpJjVkjSwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMyv8HozgmCeeXedZunPR604qKUFCatc+u4Wh7/+dgDyIiIeje
	4GMQFBQwVbK8ZzWrcKg3b85rNXngQrwFAs/W0g269xfzEL6Z+gg=
X-Gm-Gg: ASbGncsmHnNkQWIoZ4+9FwyfXLkVxxpKawvfVYiw7KcEgL7yyUa2QyfeNNIe2vZhb7W
	Cj3ceSI2iDfkVMnR1nvVHlE/EB953wJAERI0aa1i+Bj1U83Zjek1o8guLn5AqdeCC95T6A1oWYu
	E/3s6dLgmnLrEUlBXdBzE/IPxj9m2jU0AspEmD2dtdfy6e3ySqXjPARUZYV58p62lsyVT9LQWO6
	CjhRK6Cl3B8gf+WXnbkcI3HncJQUL7iOR6+6nxFDYQTKzc4mEtQ9UoE/1F5iDbyTv0df4UCRLs7
	+kLgpACBD2grxcE=
X-Google-Smtp-Source: AGHT+IGCbnjXIu/6S2TwGQO8Ic9CfV7GqYNEzf43Fjxl0RuKgiIju6njdV+Avc8EdXjz1WvnCFVwrw==
X-Received: by 2002:a17:90b:2788:b0:2fa:228d:5b03 with SMTP id 98e67ed59e1d1-2fcb5a344c1mr12877092a91.19.1740072444647;
        Thu, 20 Feb 2025 09:27:24 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220e0232190sm119601395ad.186.2025.02.20.09.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 09:27:24 -0800 (PST)
Date: Thu, 20 Feb 2025 09:27:23 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	jdamato@fastly.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v2 1/7] selftests: drv-net: add a warning for
 bkg + shell + terminate
Message-ID: <Z7dl-2Lte8IyrWvw@mini-arch>
References: <20250219234956.520599-1-kuba@kernel.org>
 <20250219234956.520599-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250219234956.520599-2-kuba@kernel.org>

On 02/19, Jakub Kicinski wrote:
> Joe Damato reports that some shells will fork before running
> the command when python does "sh -c $cmd", while bash does
> an exec of $cmd directly. This will have implications for our
> ability to terminate the child process on bash vs other shells.
> Warn about using
> 
> 	bkg(... shell=True, termininate=True)
> 
> most background commands can hopefully exit cleanly (exit_wait).
> 
> Link: https://lore.kernel.org/Z7Yld21sv_Ip3gQx@LQ3V64L9R2
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

