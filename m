Return-Path: <netdev+bounces-197762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1965AAD9CF9
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 15:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1994189CBBF
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 13:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F392D8776;
	Sat, 14 Jun 2025 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcYAJAgf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AC5BA49;
	Sat, 14 Jun 2025 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749908503; cv=none; b=JSxS1xFLcZSek1e3Z6jbIcirhW1+Sjq8YoZXwcVknPW19KiWvwnOrigmOe8vyDTpkxq52ZPbMq+AdENV5eAuwZj9Zi0agbCPewfpxaZ0uzLaPLjSXx9haywYMmOdmfd3mw1mOzOxA65/ZdSjUFdT+H6FDLQj9zlPXuUptoWUYPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749908503; c=relaxed/simple;
	bh=lM3IIsUYXea4p4rUOkoeGBxOVTyK/3N04efUcluzdIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tkTugAbbZCwo/iGj17ruo0DWVfU0tk+1Cdj2q1yYRkjGFO/a6D5upEjHxKgNoO9Chk2Dr11TXKEHP28mBsOtss4/EnbHqV82zOpbEd73VSFyhc3jwb+/eFnZ3QNPQww1VSNI2+LYVOea+uTO25xId69Zf7PjvZbey6r+W1xXNm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcYAJAgf; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-610cbca60cdso2197934eaf.0;
        Sat, 14 Jun 2025 06:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749908501; x=1750513301; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pPyT/NDLG21BaGCfzzI0/BaU7HLCtAjPSFvMEJen/+g=;
        b=TcYAJAgfbSA/o2cwkYa3qwPZJftiWRnrVOxVs/KtPnTnN0MQJLt9gaqvG3mAMri/Eb
         CGP2SiQ2Fs7bqnv3EUEOXfnfHA7NrcxEN7V6+TMcuKDAO4PkgxVlKSNSmjdYEc3c0Ih8
         wge2T/9mNAf8xWCaEyTuiMTjd5ag+AgUYMbXKrBea0juoyQe499zCbb6MO1fIMbCbevm
         BlMwmFU0/NyxFAJBVZW/eAyOHJQCFssirA4rLD+PRXnN3UEeyuDbDtW9j5jXxeY/Jw4b
         s4Vw6a+n0p8pduWM7E0UrJnsZQDrVQqtH91hydd6jJ7A0KbaHcFFyqQb1XTdSvojwu60
         LMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749908501; x=1750513301;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pPyT/NDLG21BaGCfzzI0/BaU7HLCtAjPSFvMEJen/+g=;
        b=lwTbwxI4q+PuFxfFy2dODqUZiu4PKLPpgmXRja16K/Do9ftRgpalEkImKNbWiTzAIa
         cK6UTuuCcwl6BJbaQ1qwTqSFY7ru1680sjPx/0eDQ3lPfXMNxRJjWo4qhn/4VDa0RSre
         p0x73Offe118jpPxeQXV71gW7rqrArazov7nYuQ5biqMSBd38TxBSb0ij58Ay448A3SP
         Z4wwPUwtn6HiEHsV4BZ2SYdLAOfdpAeZrkTc05J8sVRc29JQDVtNzM2P8YCKKdYyDFyj
         BF2UCFupjuSROpDoFp6YrCCuUpcKUuopgkTXVwYOqbC7oTSKBq9sBYUrnaLNxvcjqXOA
         am7A==
X-Forwarded-Encrypted: i=1; AJvYcCXaHn7pdUOrFOp+MumsncAedgW+Zy0TKafX5sndPbU4J2xbtRLKfjO40bmHsMRrYMK+dvu7Zn0+@vger.kernel.org, AJvYcCXppXJygyp2TQNYia9PB2y87pGpKSGU8ZIds53hHy2Fm1LHqCZqirUF4/4RdiJTdfYpZoLvJKy7D86xVxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG0xaxlEEobkOK57Muqr7XpBbh5AXNUCO9iFCBxevua2vv2QfV
	DEHTNwzlhcBirnc+sSJhomCNJ66/GX7hMO8jAtv4E7GiNISp5vT19eIxCk/hdXyaF9BeZZB7Voc
	SNm4IaYFFDYQ87+v8rW62LSna9/Q5vNk=
X-Gm-Gg: ASbGncu5i9Yp053DW9HqA8AaL2QBtAh1gbk7jXrePv8iXU6p567BIRcNdKimwQcACAr
	yFrQNa3gK6h8FpnGAd1+3vBAiyHs+vcCO2HP93ZcnkLf6eBBcQ8RWhGfnIbRzSB3JH3GxwMT+hI
	siTravojrOyxJvzsqto5E7Fq50YH4YNQtZw+Zol0WGStDN2fHtWrp8/QVKtHITo6GtWaEk3tKnm
	g==
X-Google-Smtp-Source: AGHT+IE2dEWG7iT8GNYJep3a6JkNJ8eV4PpXFulpLxyQDVpz9R+FS91yWKJUhBNtKFcnS5H31Csgwb8w2XbcpqjcZrM=
X-Received: by 2002:a05:6870:5b92:b0:2e9:1143:584e with SMTP id
 586e51a60fabf-2eaf0bf35bdmr1877905fac.39.1749908500962; Sat, 14 Jun 2025
 06:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749891128.git.mchehab+huawei@kernel.org> <3fb42a4aa79631d69041f6750dc0d55dd3067162.1749891128.git.mchehab+huawei@kernel.org>
In-Reply-To: <3fb42a4aa79631d69041f6750dc0d55dd3067162.1749891128.git.mchehab+huawei@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Sat, 14 Jun 2025 14:41:29 +0100
X-Gm-Features: AX0GCFt_USLBH1YdqM00LqXA1QAxCvtGi6cp-lOxexZKo8IC2JWUf0FxeobXNUY
Message-ID: <CAD4GDZwCLd0rAi-FTWZ2UEsfbMtvxbFAqcLeLtE7SfiJUB2VWg@mail.gmail.com>
Subject: Re: [PATCH v4 04/14] tools: ynl_gen_rst.py: make the index parser
 more generic
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Akira Yokosawa <akiyks@gmail.com>, Breno Leitao <leitao@debian.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Ignacio Encinas Rubio <ignacio@iencinas.com>, Jan Stancek <jstancek@redhat.com>, 
	Marco Elver <elver@google.com>, Paolo Abeni <pabeni@redhat.com>, Ruben Wauters <rubenru09@aol.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, joel@joelfernandes.org, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org, 
	lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org, 
	stern@rowland.harvard.edu
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Jun 2025 at 09:56, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> It is not a good practice to store build-generated files
> inside $(srctree), as one may be using O=<BUILDDIR> and even
> have the Kernel on a read-only directory.
>
> Change the YAML generation for netlink files to allow it
> to parse data based on the source or on the object tree.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  tools/net/ynl/pyynl/ynl_gen_rst.py | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)

It looks like this patch is no longer required since this script
doesn't get run by `make htmldocs` any more.

Instead, I think there is cleanup work to remove unused code like
`generate_main_index_rst`

This whole script may be unnecessary now, unless we want a simple way
to run YnlDocGenerator separately from the main doc build.

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
> --
> 2.49.0
>

