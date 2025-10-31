Return-Path: <netdev+bounces-234620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2C4C24BD5
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 12:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2395B4F4012
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 11:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F013446D2;
	Fri, 31 Oct 2025 11:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="tgQ/MiDz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9403321AE
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 11:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909185; cv=none; b=Gk+TR8P/lXn9t1IDRVvqTk71R5vHebX4Z7RW7jGi6lpCUMB1b8YzX9SZkNWnQMDOP2mzNih8e7GtvWq3kBI4BoqgvscRr7C3VIwxUz4KTO01RXckg8gwbtnTb+OBQ9+ynkm6/6z+JO6uUvHkvw54J6eayo2xtkTC82l/gvXJ62I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909185; c=relaxed/simple;
	bh=/GF/36swnj3HxX2vsTvl7z6HQm3i0r5EB3YUwAA95SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5/Cr4tc2SHgw/vlPZgZO16m/hYYZ67a3d3XTBW/BlK4z69OumRzmgCmKS1p9hdioQaFB1QgPIbdhbNXGMgBOsKSWQwLjXa4frDyXAfMLj+A4u4NkKIxKgYu2N5MlfKkRJgGSj7pIcRQ7o0m5jY789oPa+XX6Wd0zEbCl1bxzsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=tgQ/MiDz; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b403bb7843eso461183366b.3
        for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 04:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1761909182; x=1762513982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/GF/36swnj3HxX2vsTvl7z6HQm3i0r5EB3YUwAA95SQ=;
        b=tgQ/MiDzWN8vF4z0IMUa6f6U2ouDClkpFpORYt+0S+IcdYcSlfRmSE+4tl961QAE8I
         ZLFEV5b+sonJNwCVMz0bs+q0FrCkRaZCklHfEZf/rbffRF72P8xoPIPLZLi/wQ4ypXqs
         8K2Q5dQbAYmPJgxoD+ubsf1yolgt4cCBrvrrYLnzhDrq5PS9iZWcKABhVuVWXkAZ9wSi
         /7DSQL654XP7LVxzJn3LgcWK5ji88aQBL4gFPPwOfGTd/k8a3Q3MVFg9q32RmzanGINY
         i3CsO0PC7xP8tyZnCxhkjBLGXTiSfVN1/tWJHXLzsUhfhjmx0iv2Ncepe3eIzePb+ILK
         oiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761909182; x=1762513982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GF/36swnj3HxX2vsTvl7z6HQm3i0r5EB3YUwAA95SQ=;
        b=WgcdFpo/3EwnZbUEpPS+TZXAftA7Bl20jgQ8O5ivIRawoAA7dyWz3DhOXB3yvwk25B
         opL5A8Idwcj9KW0LsBT6wMCcjEoe+H84BFt+iq31CC4YLdQzidmJYYSx5Vj0C2h7NF0J
         N+EPbNdT1KJ4xBpNON15cxfrjYIirj6YCXn7WbpWK4dOlsYQm7qr6KitOrbPfsKbpirx
         CxFfprQZtOedl6MTcs16BilsisQ+gWRXNXaMj0VF5Qday9uJ6imq72ZzQqirhk3JBkH7
         GRqB33ZjRUenm+C9D5w4O2eycfgQPtXhBPTK79EgInj1cf4E83P7DNSVWqUxkiIZBUX6
         pJSw==
X-Gm-Message-State: AOJu0YylRZlr3qX5Exe6RdFOHTXpYgOqnf4j1445jJh2w3W2SLobXZMm
	otWjfLi6ge30Q+70Fm/YDpYgZjz5Xe46M/HrP1gmBeN47Iajd/be/84gmDMsPllG5EE=
X-Gm-Gg: ASbGncsnElXloYasB/zHthru/XlfdRzBVn/U2VkEfLdrjYfJyeOVUc42ziR3vV6SNoK
	+p7tNjCnWVbF/2t9XYGRroNr+ULyu1qMfPmkemVhlA2lh0RyELSvzlO2TKDjQP5W2s7d43BkOpQ
	6+WvFFwE6NUiXhX3hzXhcoxwOI0NNeMgWDbMCFy5Z2PQdaLdO18UedM//zMqoMJqX1hg/dGRP7j
	Mm/zUpxvTqK15loPxHc2dyFsIhCYIb9iaVQx7Xm0FdLHdU00riftUB26KYnr9JztdlcIdXgVhCE
	Z5S2LPqGqOR78fZrQ6SIptqBWl/RLsDQCuqtlNjwQB5B5+zjZNPgAEZg3Y+8AF3Nmq1BQiwzZhk
	gnfwSBuvxz3sQU72YzdCLG/lMvUynJPyo0sbszmj3yy9W4C/j97CncK7isLnRDA0lSARS1jwtiC
	ArdalTiIJmBvYjgcAH1zvd9Dh+
X-Google-Smtp-Source: AGHT+IHF0AaowGlXXnTV9muU/eRGHs3kpcT3aHx54icw1iGBrSo5gvHZWmrUEDw4u3lT2X6Kp/8q9A==
X-Received: by 2002:a17:907:3f8b:b0:b04:5e64:d7cd with SMTP id a640c23a62f3a-b707060e439mr330499766b.46.1761909181620;
        Fri, 31 Oct 2025 04:13:01 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077975d77sm151037766b.9.2025.10.31.04.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:13:01 -0700 (PDT)
Date: Fri, 31 Oct 2025 12:13:00 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, 
	David Ahern <dsahern@kernel.org>, Petr Oros <poros@redhat.com>
Subject: Re: [PATCH iproute2-next] devlink: Add support for 64bit parameters
Message-ID: <z6xecd4wjatpzvxxtrqkphc4whr6ypha3shlovg6unl7pwntas@6iaxwgbsgz3d>
References: <20251030194200.1006201-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030194200.1006201-1-ivecera@redhat.com>

Thu, Oct 30, 2025 at 08:42:00PM +0100, ivecera@redhat.com wrote:
>Kernel commit c0ef144695910 ("devlink: Add support for u64 parameters")
>added support for 64bit devlink parameters, add the support for them
>also into devlink utility userspace counterpart.
>
>Cc: Jiri Pirko <jiri@resnulli.us>
>Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

