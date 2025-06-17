Return-Path: <netdev+bounces-198584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FC1ADCC3A
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3172F3BED42
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0E52EACF6;
	Tue, 17 Jun 2025 13:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWXSZTIR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51702E7F37;
	Tue, 17 Jun 2025 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750165206; cv=none; b=h0+uY3kqBRGUg6M+D+0zfy5/w4u5lQMKJB7DT5wUKpysSMUTcWFoPT9pmfc2Ky0rQJcCB9d6w5j7R1Bsl+xfNdwPUyWJEycC3F/3JTtfzIy8h3Phul8+VmrMuBn/E1K2vouZtWI7oIEtt6MSWqWjHoJZNTpkVXlnQhX+v07e23c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750165206; c=relaxed/simple;
	bh=8uP6LT+ukBwhaivCh05LcJGGOB2/OgSp8Re0GYi7SoU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=WHozlywzmzJudWSUNylgB/BsmipKtiols1PbGCSUxH0/uE5QOLSi/Xr/9g1hz/4eOn3lF1ujsqlFOwMHZdYzH9qu2CX2c+6ub7MTD7k6O7dzpm8mV90gAqBtrTw95VknwZLfktOkYgso8mNPGrJje1FLzbLzPWn0MTg5TxHBgaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWXSZTIR; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-450d668c2a1so45281995e9.0;
        Tue, 17 Jun 2025 06:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750165203; x=1750770003; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vjsWg6wjDm6jQcEuM4LRUlfdhggu9x3buFoTSjnXWV0=;
        b=YWXSZTIRz1ECj+7XhRiwO8d75KyBkq2NupoblpK/8uTURWmfn3h+/FXjM1+Zz8haus
         ZZUP+Hv/GDEV9cRqfm8ivesWU6uPKh2Sde83PyPcW/ttubEzmLrM/w1BUnnN4RCGy1lq
         NJkT9pDpgD/rzQZD5YMYGCKwwbNPV+dWOAzpDPkIDsM+uOZsUfkmfXBRw4kEfcs4ow1m
         +VIr6HU1eeINvL8BQUXdeAMHZl+CvWwQbTlIfvblgfbjjaQKevh1ugoaJX9ArkdqVf+3
         TCeioVN4Y3hJjibRQXkUpJLa5LHXXj013+vd0Oo8lpwQu9591ZHKFVVM3ZUBBUG9ffle
         iutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750165203; x=1750770003;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjsWg6wjDm6jQcEuM4LRUlfdhggu9x3buFoTSjnXWV0=;
        b=I3G18Zz5EXG/OMvqwctauKOkCc3unuHLewBJ9wO+1b262aLh4/YqU/rWpMlyMRPTQQ
         ODC3MMNHvVbnCutJGlDs3quf0SOM85oPS3tT0zks4rSq4z6o4RFNURpGU32eLFvgv7kc
         5i99UvJjSkNpy/DNPhw6XmQrNhEcaP1JbslOdB7qQKkwC6P+2gEfwXTTCsT3Y0Y8SAeH
         22LK2z9ABhusv+Y+ecdhDdy6+BCr59c2fm+XLpv3JDDT1W4kouZyoRULlr+7+W++J+++
         d69OTTTNQk1FOuMEE7T7Pyv+N1YX+8iDWF/jQ9I+AqIysNSlwm/BcJW5SfjDGwGh5G5/
         t2NA==
X-Forwarded-Encrypted: i=1; AJvYcCVT+5sNlS5bSjUEtOpp3jdRiIpZRpMIDlrHkQCwAwSt3njWlV8JE/KKhj/KWtE+kL3KYynRTwxuI4vE4XY=@vger.kernel.org, AJvYcCW8ty5ele3m0jyJYSHhkLxFu/6/2G4rzzI9TQEC2onGUzr8ow91JDPWrQfuCBxKx34KX0w4Qp1y@vger.kernel.org
X-Gm-Message-State: AOJu0YyoXcOUybG+pcSUEGIheInpW/cm9aaXc7WjPQfS0+ffuQY22o0Z
	yodJ138YWYzemJFZ2IlykoS75IcYITWJEJ8BEQjzyboVH30dfFb90xDQ
X-Gm-Gg: ASbGnculQcPxD8np8RwFS0WZdCVIrFHFcs042I3G2BwdMBBPu8R4ivzyTBiv4NGzqrY
	fvVSc3tOt+oB1cfkdn/ujv/rkC4zJtl20u6ROvMEQWqo31sPhPArcULIGloV4qHeY+5GUVagizK
	xNRppMz+Y8ofrQw0jlZZqlh4C8IKq/4eW4lsayktSnj1LX0w5m63SKW/pnfbNji9aV8KYTwnpwk
	ha9CNqR2LgaXQPTHnGlwksk6s3XKHTzYb94EkfLC7w5noG6+t3MPJEH6wFFf8hjwM5susB6Ezdc
	3ENV8j4U5sTJK3meKVLEdE3ImyFMTo2iZHoNL74FCxW4PYtVaJFatZmqQSz28TluLq4b3IL4zjQ
	=
X-Google-Smtp-Source: AGHT+IHwwj7CVw6Bj8pFNgBnFdrKM0yuR71YOBGRt973FfrCTBcEA9FDVb4CUIvYdZXyY6zM61Orhw==
X-Received: by 2002:a05:6000:2504:b0:3a4:e624:4ec9 with SMTP id ffacd0b85a97d-3a572384087mr10993800f8f.3.1750165203029;
        Tue, 17 Jun 2025 06:00:03 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:8931:baa3:a9ed:4f01])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b089d8sm14174223f8f.57.2025.06.17.06.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 06:00:02 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,  Jonathan Corbet
 <corbet@lwn.net>,  "Akira Yokosawa" <akiyks@gmail.com>,  "Breno Leitao"
 <leitao@debian.org>,  "David S. Miller" <davem@davemloft.net>,  "Eric
 Dumazet" <edumazet@google.com>,  "Ignacio Encinas Rubio"
 <ignacio@iencinas.com>,  "Jan Stancek" <jstancek@redhat.com>,  "Marco
 Elver" <elver@google.com>,  "Paolo Abeni" <pabeni@redhat.com>,  "Ruben
 Wauters" <rubenru09@aol.com>,  "Shuah Khan" <skhan@linuxfoundation.org>,
  joel@joelfernandes.org,  linux-kernel-mentees@lists.linux.dev,
  linux-kernel@vger.kernel.org,  lkmm@lists.linux.dev,
  netdev@vger.kernel.org,  peterz@infradead.org,  stern@rowland.harvard.edu
Subject: Re: [PATCH v5 05/15] tools: ynl_gen_rst.py: make the index parser
 more generic
In-Reply-To: <1cd8b28bfe159677b8a8b1228b04ba2919c8aee8.1750146719.git.mchehab+huawei@kernel.org>
Date: Tue, 17 Jun 2025 11:55:53 +0100
Message-ID: <m2jz5ak56u.fsf@gmail.com>
References: <cover.1750146719.git.mchehab+huawei@kernel.org>
	<1cd8b28bfe159677b8a8b1228b04ba2919c8aee8.1750146719.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> It is not a good practice to store build-generated files
> inside $(srctree), as one may be using O=<BUILDDIR> and even
> have the Kernel on a read-only directory.
>
> Change the YAML generation for netlink files to allow it
> to parse data based on the source or on the object tree.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Please drop this patch. It introduces changes that affect interim
patches and the functionality all gets dropped later in the series.

> ---
>  tools/net/ynl/pyynl/ynl_gen_rst.py | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/tools/net/ynl/pyynl/ynl_gen_rst.py b/tools/net/ynl/pyynl/ynl_gen_rst.py
> index 7bfb8ceeeefc..b1e5acafb998 100755
> --- a/tools/net/ynl/pyynl/ynl_gen_rst.py
> +++ b/tools/net/ynl/pyynl/ynl_gen_rst.py
> @@ -365,6 +365,7 @@ def parse_arguments() -> argparse.Namespace:
>  
>      parser.add_argument("-v", "--verbose", action="store_true")
>      parser.add_argument("-o", "--output", help="Output file name")
> +    parser.add_argument("-d", "--input_dir", help="YAML input directory")
>  
>      # Index and input are mutually exclusive
>      group = parser.add_mutually_exclusive_group()
> @@ -405,11 +406,14 @@ def write_to_rstfile(content: str, filename: str) -> None:
>      """Write the generated content into an RST file"""
>      logging.debug("Saving RST file to %s", filename)
>  
> +    dir = os.path.dirname(filename)
> +    os.makedirs(dir, exist_ok=True)
> +
>      with open(filename, "w", encoding="utf-8") as rst_file:
>          rst_file.write(content)
>  
>  
> -def generate_main_index_rst(output: str) -> None:
> +def generate_main_index_rst(output: str, index_dir: str) -> None:
>      """Generate the `networking_spec/index` content and write to the file"""
>      lines = []
>  
> @@ -418,12 +422,18 @@ def generate_main_index_rst(output: str) -> None:
>      lines.append(rst_title("Netlink Family Specifications"))
>      lines.append(rst_toctree(1))
>  
> -    index_dir = os.path.dirname(output)
> -    logging.debug("Looking for .rst files in %s", index_dir)
> +    index_fname = os.path.basename(output)
> +    base, ext = os.path.splitext(index_fname)
> +
> +    if not index_dir:
> +        index_dir = os.path.dirname(output)
> +
> +    logging.debug(f"Looking for {ext} files in %s", index_dir)
>      for filename in sorted(os.listdir(index_dir)):
> -        if not filename.endswith(".rst") or filename == "index.rst":
> +        if not filename.endswith(ext) or filename == index_fname:
>              continue
> -        lines.append(f"   {filename.replace('.rst', '')}\n")
> +        base, ext = os.path.splitext(filename)
> +        lines.append(f"   {base}\n")
>  
>      logging.debug("Writing an index file at %s", output)
>      write_to_rstfile("".join(lines), output)
> @@ -447,7 +457,7 @@ def main() -> None:
>  
>      if args.index:
>          # Generate the index RST file
> -        generate_main_index_rst(args.output)
> +        generate_main_index_rst(args.output, args.input_dir)
>  
>  
>  if __name__ == "__main__":

